import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.primary,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmallWhite,
      ),
    );
  }
}
