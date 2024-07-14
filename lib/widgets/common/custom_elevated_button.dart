import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/utils/widgets/get_elevated_button_padding.dart';
import 'package:ultrasound_clinic/widgets/common/loading_circular_bar.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonSize,
    this.isLoading,
  });

  final String text;
  final ButtonSize? buttonSize;
  final bool? isLoading;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: getElevatedButtonPadding(buttonSize),
      ),
      child: (isLoading != null && isLoading == true)
          ? LoadingCircularBar(isButtonLoader: isLoading!)
          : Text(
              text,
              style: Theme.of(context).textTheme.headlineSmallWhite,
            ),
    );
  }
}
