import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: ThemeColors.gray200,
            indent: 20,
            endIndent: 0,
            thickness: 1.5,
            height: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmallGray,
          ),
        ),
        Expanded(
          child: Divider(
            color: ThemeColors.gray200,
            indent: 0,
            endIndent: 18,
            thickness: 1.5,
            height: 10,
          ),
        ),
      ],
    );
  }
}
