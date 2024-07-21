import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/core/services/firebase/firebase_auth_service.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/auth/login_screen.dart';
import 'package:ultrasound_clinic/widgets/login/forget_password_form.dart';

class ForgetPasswordContainer extends StatefulWidget {
  const ForgetPasswordContainer({super.key});

  @override
  State<ForgetPasswordContainer> createState() =>
      _ForgetPasswordContainerState();
}

class _ForgetPasswordContainerState extends State<ForgetPasswordContainer> {
  bool _isLoading = false;
  final FirebaseAuthService _authService = FirebaseAuthService();

  void onForgetPassword(String email) async {
    setState(() {
      _isLoading = true;
    });
    final response = await _authService.sendPasswordResetEmail(email);
    setState(() {
      _isLoading = false;
    });
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Strings.passwordResetEmailSent),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Strings.anErrorOccurredPleaseTryAgainLater),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ForgetPasswordForm(
      isLoading: _isLoading,
      onForgetPassword: onForgetPassword,
    );
  }
}
