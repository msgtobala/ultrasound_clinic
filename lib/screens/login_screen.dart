import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:ultrasound_clinic/containers/login/login_form_container.dart';
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/routes.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_divider.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 320,
                child: Stack(
                  children: [
                    // Image.asset('placeholder'),
                    Column(
                      children: [
                        Text(Strings.signIn),
                        Text(Strings.enterSignInDetails)
                      ],
                    )
                  ],
                ),
              ),
              const LoginFormContainer(),
              SizedBox(height: 26.h),
              const CustomDivider(text: Strings.orLoginWithSocialAccount),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () {},
                icon: Image.asset(Images.google),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: Strings.haveAnAccount),
                    const WidgetSpan(child: SizedBox(width: 10)),
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
            ],
          ),
        ),
      ),
    );
  }
}
