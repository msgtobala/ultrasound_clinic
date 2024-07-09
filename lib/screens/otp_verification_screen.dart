import 'package:flutter/material.dart';

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
              const SizedBox(
                width: double.infinity,
                height: 320,
                child: Stack(
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
              const SizedBox(height: 16),
              const OtpVerificationContainer(),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: Strings.didNotReceiveCode),
                    const WidgetSpan(child: SizedBox(width: 10)),
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
