import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/change_password.dart';

class ChangePasswordContainer extends StatefulWidget {
  const ChangePasswordContainer({super.key});

  @override
  State<ChangePasswordContainer> createState() =>
      _ChangePasswordContainerState();
}

class _ChangePasswordContainerState extends State<ChangePasswordContainer> {
  bool _isLoading = false;

  void onChangePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });
    final response = await authProvider.changeUserPassword(
      email,
      oldPassword,
      newPassword,
    );
    setState(() {
      _isLoading = false;
    });
    if (response) {
      showSnackbar(context, Strings.passwordChangedSuccessfully);
    } else {
      showSnackbar(context, Strings.anErrorOccurred);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangePasswordWidget(
      isLoading: _isLoading,
      onChangePassword: onChangePassword,
    );
  }
}
