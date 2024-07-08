import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_button.dart';
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
      padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 20.px),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FormInput(text: Strings.code),
            SizedBox(
              height: 30.px,
            ),
            CustomElevatedButton(text: Strings.submit, onPressed: () {})
          ],
        ),
      ),
    );
  }
}
