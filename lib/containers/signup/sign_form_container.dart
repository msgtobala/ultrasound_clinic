import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/routes/routes.dart';
import 'package:ultrasound_clinic/widgets/signup/signup_form_widget.dart';

class SignFormContainer extends StatelessWidget {
  const SignFormContainer({super.key});

  Future<void> onSignup({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
    required String role,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.signUp(userName, email, password, role);
    if (!response.error && context.mounted) {
      Navigator.of(context).pushNamed(Routes.signUpSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignupFormWidget(onSignup: onSignup);
  }
}
