import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/utils/widgets/get_elevated_button_padding.dart';
import 'package:ultrasound_clinic/widgets/common/custom_loader/custom_loader.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonSize,
    this.isLoading,
    this.buttonTextStyle,
  });

  final String text;
  final ButtonSize? buttonSize;
  final bool? isLoading;
  final TextStyle? buttonTextStyle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: getElevatedButtonPadding(buttonSize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.d),
        ),
      ),
      child: (isLoading != null && isLoading == true)
          ? SpinKitThreeBounce(color: ThemeColors.white, size: 27)
          : Text(
              text,
              style: buttonTextStyle ??
                  Theme.of(context).textTheme.headlineSmallWhite,
            ),
    );
  }
}
