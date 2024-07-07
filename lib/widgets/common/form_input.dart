import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class FormInput extends StatelessWidget {
  const FormInput({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        label: Padding(
          padding: EdgeInsets.all(8.0.px),
          child: Text(text),
        ),
        labelStyle: Theme.of(context).textTheme.displayMediumGray,
      ),
    );
  }
}
