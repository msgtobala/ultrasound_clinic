import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_image_input.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class CustomDashedInput extends StatelessWidget {
  const CustomDashedInput({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: ThemeColors.primary,
      borderType: BorderType.RRect,
      radius: const Radius.circular(50),
      dashPattern: const [8, 4],
      strokeWidth: 2,
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: CustomImageInput(
          text: text,
          onPressed: () {},
          icon: SVGLoader(
            image: Images.addFile,
            width: 30.w,
            height: 30.h,
          ),
        ),
      ),
    );
  }
}
