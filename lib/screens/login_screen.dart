import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultrasound_clinic/containers/login/login_form_container.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_divider.dart';
// import 'package:ultrasound_clinic/screens/signup.dart';
// import 'package:ultrasound_clinic/widgets/custom_divider.dart';
// import 'package:ultrasound_clinic/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              // SizedBox(height: 26.px),
              const CustomDivider(text: Strings.orLoginWithSocialAccount),
              // SizedBox(height: 16.h),
              // SizedBox(height: 16.h),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: Strings.haveAnAccount),
                    WidgetSpan(child: SizedBox(width: 10.px)),
                    TextSpan(
                      text: Strings.registerNow,
                      style: Theme.of(context).textTheme.titleMedium,
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
