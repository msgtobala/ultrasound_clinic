import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/utils/widgets/get_elevated_button_padding.dart';
import 'package:ultrasound_clinic/widgets/common/loading_circular_bar.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Color? borderColor;
  final ButtonSize? buttonSize;
  final bool? isLoading;
  final VoidCallback onPressed;
  final TextStyle? buttonTextStyle;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.borderColor,
    this.buttonSize,
    this.isLoading,
    required this.onPressed,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: getElevatedButtonPadding(buttonSize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.d),
        ),
        side: BorderSide(
          color: borderColor ?? ThemeColors.errorColor,
          width: 1,
        ),
      ),
      child: (isLoading != null && isLoading == true)
          ? LoadingCircularBar(isButtonLoader: isLoading!)
          : Text(
              text,
              style: buttonTextStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
    );
  }
}
