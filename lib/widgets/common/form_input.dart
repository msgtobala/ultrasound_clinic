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
    this.suffixIcon,
    this.initialValue,
    this.hintText,
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
  final Widget? suffixIcon;
  final void Function()? onTap;
  final String? initialValue;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
          labelStyle: Theme.of(context).textTheme.displayMediumGray,
          hintText: hintText),
      validator: validator,
      controller: controller,
      readOnly: readOnly ?? false,
    );
  }
}
