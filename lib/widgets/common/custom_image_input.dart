import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class CustomImageInput extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final SVGLoader icon;

  const CustomImageInput({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.lightBlue[50],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              text,
              style: Theme.of(context).textTheme.displayMediumGray,
            ),
          ],
        ),
      ),
    );
  }
}
