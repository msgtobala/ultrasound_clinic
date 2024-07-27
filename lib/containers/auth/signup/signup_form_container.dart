import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/models/auth/auth_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/screens/auth/signup_successful_screen.dart';
import 'package:ultrasound_clinic/screens/patient/patient_app.dart';
import 'package:ultrasound_clinic/utils/shared_preference/shared_preference.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/signup/signup_form_widget.dart';

class SignFormContainer extends StatefulWidget {
  const SignFormContainer({super.key});

  @override
  State<SignFormContainer> createState() => _SignFormContainerState();
}

class _SignFormContainerState extends State<SignFormContainer> {
  bool _isLoading = false;

  Future<void> onSignup({
    required BuildContext context,
    required String userName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    final response =
        await authProvider.signUp(userName, email, password, phone, role);
    setState(() {
      _isLoading = false;
    });
    if (!response.error) {
      final loggedInStatuses = await SharedPreferencesUtils().getMapPrefs(
        constants.loggedInStatusFlag,
      );
      // 1. If exist, the add the user flag to false in existing object
      if (loggedInStatuses.status) {
        final Map<String, dynamic> newLoggedStatus = {
          ...loggedInStatuses.value,
          response.userId: false,
        };
        await SharedPreferencesUtils().addMapPrefs(
          constants.loggedInStatusFlag,
          newLoggedStatus,
        );
        // 2. If not, then create a new object and add the flag as false for the user
      } else {
        final Map<String, dynamic> newLoggedStatus = {
          response.userId: false,
        };
        await SharedPreferencesUtils().addMapPrefs(
          constants.loggedInStatusFlag,
          newLoggedStatus,
        );
      }
      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SignupSuccessFulScreen(),
        ));
      }
    } else {
      showSnackbar(context, response.message);
    }
  }

  Future<void> onGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final AuthModel user = await authProvider.signInWithGoogle();
    setState(() {
      _isLoading = false;
    });
    if (!user.error) {
      final loggedInStatuses = await SharedPreferencesUtils().getMapPrefs(
        constants.loggedInStatusFlag,
      );
      if (loggedInStatuses.value == null ||
          loggedInStatuses.value[user.userId] == null ||
          loggedInStatuses.value[user.userId] == false) {
        final Map<String, dynamic> newLoggedStatus = {
          if (loggedInStatuses.value != null) ...loggedInStatuses.value,
          user.userId: true,
        };
        await SharedPreferencesUtils().addMapPrefs(
          constants.loggedInStatusFlag,
          newLoggedStatus,
        );
      }
      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const PatientApp(),
        ));
      }
    } else {
      showSnackbar(context, user.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignupFormWidget(
      isLoading: _isLoading,
      onSignup: onSignup,
      onGoogleSignin: onGoogleSignIn,
    );
  }
}
