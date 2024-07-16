import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class PillActionButton extends StatelessWidget {
  final String text;
  final String? icon;
  final IconData? iconData;
  final double? width;
  final void Function() onTap;

  const PillActionButton({
    super.key,
    required this.text,
    this.icon,
    this.iconData,
    this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: width ?? 110.w,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: ThemeColors.lightBlue,
          borderRadius: BorderRadius.circular(20.d),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLargeLight,
            ),
            SizedBox(width: 10.w),
            if (icon != null)
              SizedBox(width: 18, height: 18, child: SVGLoader(image: icon!)),
            if (iconData != null)
              Icon(
                iconData,
                color: ThemeColors.darkBlue,
                size: 20,
              )
          ],
        ),
      ),
    );
  }
}
