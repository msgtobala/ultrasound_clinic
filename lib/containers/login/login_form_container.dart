import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/constants/enums/role_enum.dart';
import 'package:ultrasound_clinic/models/auth/auth_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/clinic/clinic_app.dart';
import 'package:ultrasound_clinic/screens/patient/patient_app.dart';
import 'package:ultrasound_clinic/utils/shared_preference/shared_preference.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/login/login_form_widget.dart';

class LoginFormContainer extends StatefulWidget {
  const LoginFormContainer({super.key});

  @override
  State<LoginFormContainer> createState() => _LoginFormContainerState();
}

class _LoginFormContainerState extends State<LoginFormContainer> {
  bool _isLoading = false;

  Future<void> onSignIn(String userEmail, String userPassword) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    final AuthModel user = await authProvider.signIn(userEmail, userPassword);
    if (user.error) {
      if (context.mounted) {
        showSnackbar(context, user.message);
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      if (!user.isEmailVerified) {
        showSnackbar(context, Strings.pleaseVerfiyYourEmail);
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final loggedInStatuses = await SharedPreferencesUtils().getMapPrefs(
        constants.loggedInStatusFlag,
      );
      if (loggedInStatuses.value == null ||
          loggedInStatuses.value[user.userId] as bool == false) {
        final Map<String, dynamic> newLoggedStatus = {
          if (loggedInStatuses.value != null) ...loggedInStatuses.value,
          user.userId: true,
        };
        await SharedPreferencesUtils().addMapPrefs(
          constants.loggedInStatusFlag,
          newLoggedStatus,
        );
      }
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => user.role == UserRoleEnum.clinic.roleName
                ? const ClinicApp()
                : const PatientApp(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginFormWidget(
      isLoading: _isLoading,
      onSignIn: onSignIn,
    );
  }
}
