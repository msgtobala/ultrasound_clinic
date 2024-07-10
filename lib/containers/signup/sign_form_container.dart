import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/routes/routes.dart';
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
    if (!response.error && context.mounted) {
      Navigator.of(context).pushNamed(Routes.signUpSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignupFormWidget(isLoading: _isLoading, onSignup: onSignup);
  }
}
