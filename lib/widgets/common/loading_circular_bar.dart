import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

/// Use [LoadingCircularBar] in the places of loader.
/// If you want to use for Page use like this
///  LoadingCircularBar();
/// If you want to use for Buttons use like this
/// LoadingCircularBar(
/// isButtonLoader = true;
/// );
///

class LoadingCircularBar extends StatelessWidget {
  final bool isButtonLoader;
  final double? strokeWidth;

  const LoadingCircularBar({
    super.key,
    this.isButtonLoader = false,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final Widget loader = CircularProgressIndicator(
      backgroundColor: ThemeColors.darkBlue,
      valueColor: AlwaysStoppedAnimation<Color>(
        ThemeColors.white,
      ),
      strokeWidth: strokeWidth ?? 4.0,
    );
    return isButtonLoader
        ? SizedBox(
            height: 20.d,
            width: 20.d,
            child: loader,
          )
        : loader;
  }
}
