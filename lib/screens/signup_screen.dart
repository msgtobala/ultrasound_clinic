import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:ultrasound_clinic/containers/signup/sign_form_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/routes.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_divider.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.login);
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
          SizedBox(height: 26.h),
          const CustomDivider(text: Strings.orRegisterWithSocialAccount),
          SizedBox(height: 16.h),
          const SVGLoader(image: Images.google),
          SizedBox(height: 59.h),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: Strings.alreadyHaveAnAccount),
                WidgetSpan(child: SizedBox(width: 10.h)),
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
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
