import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/auth/login/forget_password_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/strings.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      pageTitle: Strings.forgotPassword,
      pageDescription: Strings.enterEmailToResetPassword,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ForgetPasswordContainer(),
        ],
      ),
    );
  }
}
