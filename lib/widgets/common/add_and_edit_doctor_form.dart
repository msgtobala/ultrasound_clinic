import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/constants/constants.dart';

import 'package:ultrasound_clinic/models/common/form_model.dart';
import 'package:ultrasound_clinic/resources/regex.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';
import 'package:ultrasound_clinic/widgets/common/generic_media_dialog.dart';

class AddAndEditDoctorForm extends StatefulWidget {
  final bool isEdit;
  const AddAndEditDoctorForm({super.key, required this.isEdit});

  @override
  State<AddAndEditDoctorForm> createState() => _AddAndEditDoctorFormState();
}

class _AddAndEditDoctorFormState extends State<AddAndEditDoctorForm> {
  final _formKey = GlobalKey<FormState>();
  final _degreeController = TextEditingController();
  File? _image;
  bool _isUploadValid = true;
  bool _isValidDegree = true;

  final Map<String, String> formData = {
    'name': '',
    'phone': '',
    'degree': '',
    'description': '',
  };
  final List<FormModel> formInputs = [
    FormModel(
      label: "Doctor Name",
      type: 'text',
      key: 'name',
      keyboardType: TextInputType.name,
    ),
    FormModel(
      label: Strings.phoneNumber,
      type: 'text',
      key: 'phone',
      keyboardType: TextInputType.phone,
    ),
    FormModel(
      label: "Degree",
      type: 'dropdown',
      key: 'degree',
      keyboardType: TextInputType.name,
    ),
    FormModel(
      label: "Description",
      type: 'text',
      key: 'desc',
      keyboardType: TextInputType.name,
    ),
    FormModel(
      label: "upload profile picture",
      type: 'upload',
      key: 'profile',
    ),
  ];
  void _onSaved(String key, String? value) {
    formData[key] = value!;
  }

  String? validator(
    String key,
    String? value,
  ) {
    final phonePattern = RegExp(Regex.phoneRegEx);

    if (key == 'name' && (value == null || value.isEmpty)) {
      return Strings.invalidPatientName;
    }

    if (key == 'phone' &&
        (value == null || value.isEmpty || !phonePattern.hasMatch(value))) {
      return Strings.invalidMobileNumber;
    }

    if (key == 'desc' && (value == null || value.isEmpty)) {
      return "Invalid description";
    }

    return null;
  }

  void onSaveMedia(File file) {
    setState(() {
      _image = file;
      _isUploadValid = true;
    });
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _image = null;
    _isUploadValid = true;
    _isValidDegree = true;
    formData.forEach((key, value) {
      formData[key] = '';
    });
    _degreeController.clear();
  }

  void _onAddDoctor() {
    print(formData['degree']!.isEmpty);
    bool isFormValid = _formKey.currentState!.validate();
    if (_image == null || formData['degree']!.isEmpty) {
      setState(() {
        _isUploadValid = _image == null ? false : true;
        _isValidDegree = formData['degree']!.isEmpty ? false : true;
      });
      return;
    }
    if (isFormValid) {
      _formKey.currentState!.save();
      //
      resetForm();
    }
  }

  void _onProfileUpload() {
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

  void onDropDownSelected(dynamic value) {
    formData['degree'] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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

            if (input.type == 'dropdown') {
              return Column(
                key: Key(input.label),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DropdownMenu(
                    controller: _degreeController,
                    width: MediaQuery.of(context).size.width - 40.w,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.d),
                      ),
                    ),
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    dropdownMenuEntries: constants.doctorDegrees
                        .map((degree) => degree)
                        .toList(),
                    label: Text(
                      Strings.mediaType,
                      style: Theme.of(context).textTheme.displayMediumGray,
                    ),
                    onSelected: onDropDownSelected,
                    initialSelection: widget.isEdit ? '' : '',
                  ),
                  if (!_isValidDegree)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9.h),
                        Container(
                          margin: EdgeInsets.only(left: 10.hs),
                          child: Text(
                            'Invalid degree',
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

            if (input.type == 'upload') {
              return Column(
                key: Key(input.label),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDashedInput(
                    text: _isUploadValid && _image != null
                        ? Strings.samplePrescription
                        : input.label,
                    onTap: _onProfileUpload,
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
              onPressed: _onAddDoctor,
            ),
          ),
        ],
      ),
    );
  }
}
