import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

EdgeInsetsGeometry getElevatedButtonPadding(ButtonSize? buttonSize) {
  switch (buttonSize) {
    case ButtonSize.small:
      return EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w);
    case ButtonSize.large:
      return EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w);
    default:
      return EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w);
  }
}
