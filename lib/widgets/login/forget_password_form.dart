import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class ForgetPasswordForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String email) onForgetPassword;

  const ForgetPasswordForm({
    super.key,
    required this.isLoading,
    required this.onForgetPassword,
  });

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      widget.onForgetPassword(_email);
    }
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.invalidEmail;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormInput(
              text: Strings.email,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => {_email = value!},
              validator: (value) => validator(value!),
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              text: Strings.submit,
              buttonSize: ButtonSize.small,
              isLoading: widget.isLoading,
              onPressed: onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
