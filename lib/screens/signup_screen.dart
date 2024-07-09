import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:ultrasound_clinic/containers/signup/sign_form_container.dart';
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/routes.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_divider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.login);
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
                        Text(Strings.signUp),
                        Text(Strings.enterSignUpDetails)
                      ],
                    )
                  ],
                ),
              ),
              const SignFormContainer(),
              // SizedBox(height: 10.px),
              const CustomDivider(text: Strings.orRegisterWithSocialAccount),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () {},
                icon: Image.asset(Images.google),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: Strings.alreadyHaveAnAccount),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                      text: Strings.loginNow,
                      style: Theme.of(context).textTheme.titleMedium,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _navigateToSignUpScreen(context),
                    )
                  ],
                  style: Theme.of(context).textTheme.bodySmallBlack,
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
