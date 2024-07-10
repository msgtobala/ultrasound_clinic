import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:ultrasound_clinic/themes/colors.dart';

class OtpVerificationContainer extends StatelessWidget {
  const OtpVerificationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      onCompleted: (pin) => print(pin),
      length: 5,
      defaultPinTheme: PinTheme(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
