import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class LandingCustomButton extends StatelessWidget {
  const LandingCustomButton(
      {super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.primary,
        minimumSize: const Size(150, 50),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLargeWhite,
      ),
    );
  }
}
