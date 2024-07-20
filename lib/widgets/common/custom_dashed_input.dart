import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class CustomDashedInput extends StatelessWidget {
  final String text;
  final Function() onTap;

  const CustomDashedInput({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: ThemeColors.primary,
      borderType: BorderType.RRect,
      radius: Radius.circular(10.d),
      dashPattern: const [8, 4],
      strokeWidth: 2,
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.d)),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.vs, horizontal: 20.hs),
            decoration: BoxDecoration(color: ThemeColors.lightBlue),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: const SVGLoader(image: icons.Icons.addFile),
                ),
                SizedBox(width: 10.w),
                Text(
                  text,
                  style: Theme.of(context).textTheme.displayMediumGray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
