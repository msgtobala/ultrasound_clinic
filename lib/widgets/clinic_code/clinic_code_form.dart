import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/constants/enums/button_size.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class ClinicCodeForm extends StatefulWidget {
  const ClinicCodeForm({super.key});

  @override
  State<ClinicCodeForm> createState() => _ClinicCodeFormState();
}

class _ClinicCodeFormState extends State<ClinicCodeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FormInput(text: Strings.code),
            const SizedBox(height: 30),
            CustomElevatedButton(
              text: Strings.submit,
              buttonSize: ButtonSize.large,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
