import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/models/common/doctor_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/regex.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_avatar.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';
import 'package:ultrasound_clinic/widgets/common/generic_media_dialog.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class EditDoctorForm extends StatefulWidget {
  final bool isLoading;
  final DoctorModel currentDoctor;
  final Function(String doctorId, Map<String, String> formData, File? file)
      onEdit;

  const EditDoctorForm({
    super.key,
    required this.currentDoctor,
    required this.isLoading,
    required this.onEdit,
  });

  @override
  State<EditDoctorForm> createState() => _EditDoctorFormState();
}

class _EditDoctorFormState extends State<EditDoctorForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _doctorNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _degreeController;
  late TextEditingController _descriptionController;
  bool _isUploadValid = true;
  bool _isDirty = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    _doctorNameController =
        TextEditingController(text: widget.currentDoctor.doctorName);
    _phoneNumberController =
        TextEditingController(text: widget.currentDoctor.phoneNumber);
    _degreeController =
        TextEditingController(text: widget.currentDoctor.degree);
    _descriptionController =
        TextEditingController(text: widget.currentDoctor.description);

    _doctorNameController.addListener(_checkIfDirty);
    _phoneNumberController.addListener(_checkIfDirty);
    _degreeController.addListener(_checkIfDirty);
    _descriptionController.addListener(_checkIfDirty);
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _phoneNumberController.dispose();
    _degreeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _checkIfDirty() {
    Future.microtask(() {
      bool? isValid = _formKey.currentState?.validate();
      bool checkIsDirty =
          _doctorNameController.text != widget.currentDoctor.doctorName ||
              _phoneNumberController.text != widget.currentDoctor.phoneNumber ||
              _degreeController.text != widget.currentDoctor.degree ||
              _descriptionController.text != widget.currentDoctor.description ||
              _image != null;
      setState(() {
        _isDirty = (isValid == true && checkIsDirty) ? true : false;
      });
    });
  }

  String? _validator(String key, String? value) {
    final phonePattern = RegExp(Regex.phoneRegEx);

    if (key == 'doctorName' && (value == null || value.isEmpty)) {
      return Strings.invalidDoctorName;
    }
    if (key == 'phoneNumber' &&
        (value == null || value.isEmpty || !phonePattern.hasMatch(value))) {
      return Strings.invalidMobileNumber;
    }
    if (key == 'description' && (value == null || value.isEmpty)) {
      return Strings.invalidDescription;
    }
    return null;
  }

  void _onDropDownSelected(dynamic value) {
    setState(() {
      _degreeController.text = value;
    });
  }

  void _onSaveMedia(File file) {
    setState(() {
      _image = file;
      _isUploadValid = true;
    });
    _checkIfDirty();
  }

  void _onProfileUpload() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenericMediaDialog(
          mediaHeading: '${Strings.doctor} ${Strings.image}',
          onSaveMedia: _onSaveMedia,
        );
      },
    );
  }

  void _onEditDoctor() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final formData = {
        'uid': widget.currentDoctor.uid,
        'doctorName': _doctorNameController.value.text,
        'degree': _degreeController.value.text,
        'description': _descriptionController.value.text,
        'phoneNumber': _phoneNumberController.value.text,
        'imageUrl': widget.currentDoctor.imageUrl,
      };
      widget.onEdit(widget.currentDoctor.uid, formData, _image);
    }
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 220.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.frameBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 35.vs),
                    child: CustomAvatar(
                      imageUrl: _image?.path ?? widget.currentDoctor.imageUrl,
                      isNetwork: _image?.path == null ? true : false,
                      radius: 45.d,
                      onTap: _onProfileUpload,
                      editMode: true,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).padding.top + 20.hs),
              left: 30.vs,
              child: InkWell(
                onTap: _goBack,
                child: SizedBox(
                  width: 15.w,
                  height: 15.h,
                  child: const SVGLoader(image: icons.Icons.back),
                ),
              ),
            ),
          ],
        ),
        Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.hs, vertical: 20.vs),
            child: Column(
              children: [
                FormInput(
                  controller: _doctorNameController,
                  text: Strings.doctorName,
                  onSaved: (value) => _doctorNameController.text = value!,
                  validator: (value) => _validator('doctorName', value),
                ),
                SizedBox(height: 20.h),
                FormInput(
                  controller: _phoneNumberController,
                  text: Strings.phoneNumber,
                  onSaved: (value) => _phoneNumberController.text = value!,
                  validator: (value) => _validator('phoneNumber', value),
                ),
                SizedBox(height: 20.h),
                DropdownMenu(
                  controller: _degreeController,
                  width: MediaQuery.of(context).size.width - 40.w,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.d),
                    ),
                  ),
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  dropdownMenuEntries:
                      constants.doctorDegrees.map((degree) => degree).toList(),
                  label: Text(
                    Strings.degree,
                    style: Theme.of(context).textTheme.displayMediumGray,
                  ),
                  onSelected: _onDropDownSelected,
                  initialSelection: _degreeController.text,
                ),
                if (!_isUploadValid)
                  Padding(
                    padding: EdgeInsets.only(left: 10.hs, top: 9.h),
                    child: Text(
                      Strings.invalidDegree,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12.f,
                      ),
                    ),
                  ),
                SizedBox(height: 20.h),
                FormInput(
                  controller: _descriptionController,
                  text: "Description",
                  onSaved: (value) => _descriptionController.text = value!,
                  validator: (value) => _validator('description', value),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: Strings.edit,
                    onPressed: _isDirty ? _onEditDoctor : null,
                    isLoading: widget.isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
