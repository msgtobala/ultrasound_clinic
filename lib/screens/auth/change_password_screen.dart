import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/auth/login/change_password_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/strings.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      pageTitle: Strings.changePassword,
      pageDescription: Strings.enterEmailAndPasswordToChangePassword,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChangePasswordContainer(),
        ],
      ),
    );
  }
}
