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

class AddAndEditStaffForm extends StatefulWidget {
  final bool isEdit;
  final bool isLoading;
  final void Function(Map<String, String>, File) addStaff;

  const AddAndEditStaffForm({
    super.key,
    required this.isEdit,
    required this.isLoading,
    required this.addStaff,
  });

  @override
  State<AddAndEditStaffForm> createState() => _AddAndEditStaffFormState();
}

class _AddAndEditStaffFormState extends State<AddAndEditStaffForm> {
  final _formKey = GlobalKey<FormState>();
  final _designationController = TextEditingController();
  File? _image;
  bool _isUploadValid = true;
  bool _isDesignationValid = true;

  final Map<String, String> formData = {
    'staffName': '',
    'phoneNumber': '',
    'designation': '',
  };
  final List<FormModel> formInputs = [
    FormModel(
      label: "Staff Name",
      type: 'text',
      key: 'staffName',
      keyboardType: TextInputType.name,
    ),
    FormModel(
      label: Strings.phoneNumber,
      type: 'text',
      key: 'phoneNumber',
      keyboardType: TextInputType.phone,
    ),
    FormModel(
      label: "Designation",
      type: 'dropdown',
      key: 'degree',
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

    if (key == 'staffName' && (value == null || value.isEmpty)) {
      return Strings.invalidStaffName;
    }

    if (key == 'phoneNumber' &&
        (value == null || value.isEmpty || !phonePattern.hasMatch(value))) {
      return Strings.invalidMobileNumber;
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
    setState(() {
      _isUploadValid = true;
      _isDesignationValid = true;
    });
    formData.forEach((key, value) {
      formData[key] = '';
    });
    _designationController.clear();
  }

  void _onAddStaff() {
    bool isFormValid = _formKey.currentState!.validate();
    if (_image == null || formData['designation']!.isEmpty) {
      setState(() {
        _isUploadValid = _image == null ? false : true;
        _isDesignationValid = formData['designation']!.isEmpty ? false : true;
      });
      return;
    }
    if (isFormValid) {
      _formKey.currentState!.save();
      widget.addStaff({...formData}, _image!);
      resetForm();
    }
  }

  void _onProfileUpload() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericMediaDialog(
          mediaHeading: '${Strings.staff} ${Strings.image}',
          onSaveMedia: onSaveMedia,
        );
      },
    );
  }

  void onDropDownSelected(dynamic value) {
    formData['designation'] = value;
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
                    controller: _designationController,
                    width: MediaQuery.of(context).size.width - 40.w,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.d),
                      ),
                    ),
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    dropdownMenuEntries: constants.staffDesignations
                        .map((staffDesignation) => staffDesignation)
                        .toList(),
                    label: Text(
                      Strings.designations,
                      style: Theme.of(context).textTheme.displayMediumGray,
                    ),
                    onSelected: onDropDownSelected,
                    initialSelection: widget.isEdit ? '' : '',
                  ),
                  if (!_isDesignationValid)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9.h),
                        Container(
                          margin: EdgeInsets.only(left: 10.hs),
                          child: Text(
                            Strings.invalidDegree,
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
                        ? Strings.sampleStaff
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
                            Strings.invalidProfileImage,
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
              onPressed: _onAddStaff,
              isLoading: widget.isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
