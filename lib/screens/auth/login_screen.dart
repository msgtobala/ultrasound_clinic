import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:ultrasound_clinic/containers/auth/login/login_form_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/auth/signup_screen.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      pageTitle: Strings.signIn,
      pageDescription: Strings.enterSignInDetails,
      offset: Offset(0, -40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LoginFormContainer(),
          SizedBox(height: 59.h),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: Strings.haveAnAccount),
                WidgetSpan(child: SizedBox(width: 5.h)),
                TextSpan(
                  text: Strings.registerNow,
                  style: Theme.of(context).textTheme.titleMedium,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _navigateToSignUpScreen(context),
                )
              ],
              style: Theme.of(context).textTheme.bodySmallBlack,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
