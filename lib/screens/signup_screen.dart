import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultrasound_clinic/containers/signup/sign_form_container.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_divider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 320.px,
                child: const Stack(
                  children: [
                    // Image.asset('placeholder'),
                    Column(
                      children: [
                        Text(Strings.signIn),
                        Text("Enter your user name and password to login!")
                      ],
                    )
                  ],
                ),
              ),
              const SignFormContainer(),
              // SizedBox(height: 10.px),
              const CustomDivider(text: Strings.orRegisterWithSocialAccount),
              SizedBox(
                height: 16.px,
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(MdiIcons.google),
              // ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: Strings.alreadyHaveAnAccount),
                    WidgetSpan(child: SizedBox(width: 10.px)),
                    TextSpan(
                      text: Strings.loginNow,
                      style: Theme.of(context).textTheme.titleMedium,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
                        },
                    )
                  ],
                  style: Theme.of(context).textTheme.bodySmallBlack,
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
