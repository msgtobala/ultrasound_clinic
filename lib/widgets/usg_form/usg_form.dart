import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/form_model.dart';
import 'package:ultrasound_clinic/resources/regex.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';
import 'package:ultrasound_clinic/widgets/common/generic_media_dialog.dart';

class USGForm extends StatefulWidget {
  final bool isLoading;
  final void Function(Map<String, dynamic> usg) addUSG;

  const USGForm({
    super.key,
    required this.isLoading,
    required this.addUSG,
  });

  @override
  State<USGForm> createState() => _USGFormState();
}

class _USGFormState extends State<USGForm> {
  File? _image;
  bool _isUploadValid = true;
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {
    'patientName': '',
    'mobileNumber': '',
    'prescription': '',
    'address': '',
    'city': '',
    'pinCode': '',
    'report': '',
  };
  final List<FormModel> formInputs = [
    FormModel(type: 'text', label: Strings.patientName, key: 'patientName'),
    FormModel(type: 'text', label: Strings.mobileNumber, key: 'mobileNumber'),
    FormModel(type: 'upload', label: Strings.prescription, key: 'prescription'),
    FormModel(type: 'text', label: Strings.address, key: 'address'),
    FormModel(label: 'Next', type: 'next', key: 'next', next: [
      FormModel(type: 'text', label: Strings.city, key: 'city'),
      FormModel(type: 'text', label: Strings.pinCode, key: 'pinCode'),
    ]),
  ];

  void resetForm() {
    _formKey.currentState?.reset();
    _image = null;
    _isUploadValid = true;
    formData.forEach((key, value) {
      formData[key] = '';
    });
  }

  void _onSaved(String key, String? value) {
    formData[key] = value!;
  }

  String? validator(
    String key,
    String? value,
  ) {
    final phonePattern = RegExp(Regex.phoneRegEx);
    final pinCodePattern = RegExp(Regex.zipCodeRegex);

    if (key == 'patientName' && (value == null || value.isEmpty)) {
      return Strings.invalidPatientName;
    }

    if (key == 'mobileNumber' &&
        (value == null || value.isEmpty || !phonePattern.hasMatch(value))) {
      return Strings.invalidMobileNumber;
    }

    if (key == 'address' && (value == null || value.isEmpty)) {
      return Strings.invalidAddress;
    }

    if (key == 'city' && (value == null || value.isEmpty)) {
      return Strings.invalidCity;
    }

    if (key == 'pinCode' &&
        (value == null || value.isEmpty || !pinCodePattern.hasMatch(value))) {
      return Strings.invalidPinCode;
    }

    return null;
  }

  void onSaveMedia(File file) {
    setState(() {
      _image = file;
      _isUploadValid = true;
    });
  }

  void _onPrescriptionUpload() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericMediaDialog(
          mediaHeading: '${Strings.prescription} ${Strings.image}',
          onSaveMedia: onSaveMedia,
        );
      },
    );
  }

  void _submitUSG() {
    bool isFormValid = _formKey.currentState!.validate();
    if (_image == null) {
      setState(() {
        _isUploadValid = false;
      });
      return;
    }
    if (isFormValid) {
      _formKey.currentState!.save();
      widget.addUSG({...formData, 'prescription': _image});
      resetForm();
    }
  }

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
                      onSaved: (value) => _onSaved(input.key, value),
                      validator: (value) => validator(input.key, value!),
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }

              if (input.type == 'next') {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      key: Key(input.label),
                      children: [
                        ...input.next!.map((nextInput) {
                          return Flexible(
                            key: Key(nextInput.label),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: FormInput(
                                text: nextInput.label,
                                onSaved: (value) =>
                                    _onSaved(nextInput.key, value),
                                validator: (value) =>
                                    validator(nextInput.key, value!),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }

              if (input.type == 'upload') {
                return Column(
                  key: Key(input.label),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDashedInput(
                      text: _isUploadValid && _image != null
                          ? Strings.samplePrescription
                          : input.label,
                      onTap: _onPrescriptionUpload,
                    ),
                    if (!_isUploadValid)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 9.h),
                          Container(
                            margin: EdgeInsets.only(left: 10.hs),
                            child: Text(
                              Strings.invalidPrescription,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12.f,
                              ),
                            ),
                          ),
                        ],
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
                onPressed: _submitUSG,
                isLoading: widget.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
