import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/form_model.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class USGForm extends StatefulWidget {
  const USGForm({super.key});

  @override
  State<USGForm> createState() => _USGFormState();
}

class _USGFormState extends State<USGForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {
    'patientName': '',
    'mobileNumber': '',
    'prescription': '',
    'address': '',
    'city': '',
    'pinCode': '',
  };
  final List<FormModel> formInputs = [
    FormModel(type: 'text', label: Strings.patientName, key: 'patientName'),
    FormModel(type: 'text', label: Strings.mobileNumber, key: 'mobileNumber'),
    FormModel(type: 'upload', label: Strings.prescription, key: 'prescription'),
    FormModel(type: 'text', label: Strings.address, key: 'address'),
    FormModel(type: 'text', label: Strings.city, key: 'city'),
    FormModel(type: 'text', label: Strings.pinCode, key: 'pinCode'),
  ];

  void _onSaved(String? value, String key) {
    formData[key] = value!;
  }

  void _onPrescriptionUpload() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...formInputs.map((input) {
              if (input.type == 'text') {
                return Column(
                  key: Key(input.label),
                  children: [
                    FormInput(
                      text: input.label,
                      onSaved: (value) => _onSaved(value, input.key),
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }

              if (input.type == 'upload') {
                return Column(
                  key: Key(input.label),
                  children: [
                    CustomDashedInput(
                      text: input.label,
                      onTap: _onPrescriptionUpload,
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }
              return const SizedBox();
            }),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.submit,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
