import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/otp_verification/otp_verification_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      pageTitle: Strings.otpVerification,
      pageDescription: Strings.verifyOTPDescription,
      offset: Offset(0, -40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OtpVerificationContainer(),
          SizedBox(height: 33.h),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: Strings.didNotReceiveCode),
                WidgetSpan(child: SizedBox(width: 10.w)),
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
    );
  }
}
