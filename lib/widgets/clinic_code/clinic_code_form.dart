import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/constants/enums/button_size.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class ClinicCodeForm extends StatefulWidget {
  final bool isLoading;
  final Function(String clinicCode) onClinicSelection;

  const ClinicCodeForm({
    super.key,
    required this.isLoading,
    required this.onClinicSelection,
  });

  @override
  State<ClinicCodeForm> createState() => _ClinicCodeFormState();
}

class _ClinicCodeFormState extends State<ClinicCodeForm> {
  final _formKey = GlobalKey<FormState>();
  String _clinicCode = '';

  void onSubmit() {
    _formKey.currentState?.save();
    widget.onClinicSelection(_clinicCode);
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
              text: Strings.code,
              onSaved: (value) => {_clinicCode = value!},
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              text: Strings.submit,
              buttonSize: ButtonSize.large,
              onPressed: onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
