import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:ultrasound_clinic/containers/auth/signup/signup_form_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/auth/login_screen.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      pageTitle: Strings.signUp,
      pageDescription: Strings.enterSignUpDetails,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SignFormContainer(),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: Strings.alreadyHaveAnAccount),
                WidgetSpan(child: SizedBox(width: 10.h)),
                TextSpan(
                  text: Strings.loginNow,
                  style: Theme.of(context).textTheme.titleMedium,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _navigateToLoginScreen(context),
                )
              ],
              style: Theme.of(context).textTheme.bodySmallBlack,
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
