import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/core/services/firebase/firebase_auth_service.dart';
import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/widgets/signup/signup_successful_widget.dart';

class SignUpSuccessfulContainer extends StatefulWidget {
  const SignUpSuccessfulContainer({super.key});

  @override
  State<SignUpSuccessfulContainer> createState() =>
      _SignUpSuccessfulContainerState();
}

class _SignUpSuccessfulContainerState extends State<SignUpSuccessfulContainer> {
  int _seconds = 5;
  Timer? _timer;

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 1) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
        _navigateToNextPage();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final currentUser = FirebaseAuthService().currentUser;
      if (currentUser != null) {
        await currentUser.sendEmailVerification();
        _startCountdown();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignupSuccessfulWidget(seconds: _seconds);
  }
}
