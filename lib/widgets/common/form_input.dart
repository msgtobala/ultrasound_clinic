import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/fonts.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.text,
    this.obscureText = false,
    this.keyboardType,
    this.onSaved,
  });

  final String text;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      onSaved: onSaved,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        labelStyle: Theme.of(context).textTheme.displayMediumGray,
      ),
    );
  }
}
