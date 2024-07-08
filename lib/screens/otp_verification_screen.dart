import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultrasound_clinic/containers/otp_verification/otp_verification_container.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

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
              SizedBox(
                height: 16.px,
              ),
              const OtpVerificationContainer(),
              SizedBox(
                height: 30.px,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: Strings.didNotRecieveCode),
                    WidgetSpan(child: SizedBox(width: 10.px)),
                    TextSpan(
                      text: Strings.resend,
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
