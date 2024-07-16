import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/fonts.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.text,
    this.obscureText = false,
    this.readOnly,
    this.keyboardType,
    this.onSaved,
    this.validator,
    this.controller,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
  });

  final String text;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final Widget? prefixIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        prefixIcon: prefixIcon,
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        labelStyle: Theme.of(context).textTheme.displayMediumGray,
      ),
      validator: validator,
      controller: controller,
      readOnly: readOnly ?? false,
    );
  }
}
