import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final BorderSide? borderSide;

  const CustomChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.labelStyle,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelStyle: labelStyle ?? Theme.of(context).textTheme.displaySmall,
      side: borderSide ?? const BorderSide(width: 0),
      backgroundColor: backgroundColor ?? ThemeColors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.d),
      ),
      label: Text(label),
    );
  }
}
