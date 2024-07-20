import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/models/common/staff_model.dart';
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

class EditStaffForm extends StatefulWidget {
  final bool isLoading;
  final StaffModel currentStaff;
  final Function(String staffId, Map<String, String> formData, File? file)
      onEdit;

  const EditStaffForm({
    super.key,
    required this.currentStaff,
    required this.isLoading,
    required this.onEdit,
  });

  @override
  State<EditStaffForm> createState() => _EditStaffFormState();
}

class _EditStaffFormState extends State<EditStaffForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _staffNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _designationController;
  bool _isUploadValid = true;
  bool _isDirty = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    _staffNameController =
        TextEditingController(text: widget.currentStaff.staffName);
    _phoneNumberController =
        TextEditingController(text: widget.currentStaff.phoneNumber);
    _designationController =
        TextEditingController(text: widget.currentStaff.designation);

    _staffNameController.addListener(_checkIfDirty);
    _phoneNumberController.addListener(_checkIfDirty);
    _designationController.addListener(_checkIfDirty);
  }

  @override
  void dispose() {
    _staffNameController.dispose();
    _phoneNumberController.dispose();
    _designationController.dispose();
    super.dispose();
  }

  void _checkIfDirty() {
    Future.microtask(() {
      bool? isValid = _formKey.currentState?.validate();
      bool checkIsDirty =
          _staffNameController.text != widget.currentStaff.staffName ||
              _phoneNumberController.text != widget.currentStaff.phoneNumber ||
              _designationController.text != widget.currentStaff.designation ||
              _image != null;
      setState(() {
        _isDirty = (isValid == true && checkIsDirty) ? true : false;
      });
    });
  }

  String? _validator(String key, String? value) {
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

  void _onDropDownSelected(dynamic value) {
    setState(() {
      _designationController.text = value;
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
          mediaHeading: '${Strings.staff} ${Strings.image}',
          onSaveMedia: _onSaveMedia,
        );
      },
    );
  }

  void _onEditStaff() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final formData = {
        'uid': widget.currentStaff.uid,
        'staffName': _staffNameController.value.text,
        'designation': _designationController.value.text,
        'phoneNumber': _phoneNumberController.value.text,
        'imageUrl': widget.currentStaff.imageUrl,
      };
      widget.onEdit(widget.currentStaff.uid, formData, _image);
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
                      imageUrl: _image?.path ?? widget.currentStaff.imageUrl,
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
                  controller: _staffNameController,
                  text: Strings.staffName,
                  onSaved: (value) => _staffNameController.text = value!,
                  validator: (value) => _validator('staffName', value),
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
                  controller: _designationController,
                  width: MediaQuery.of(context).size.width - 40.w,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.d),
                    ),
                  ),
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  dropdownMenuEntries: constants.staffDesignations
                      .map((designation) => designation)
                      .toList(),
                  label: Text(
                    Strings.degree,
                    style: Theme.of(context).textTheme.displayMediumGray,
                  ),
                  onSelected: _onDropDownSelected,
                  initialSelection: _designationController.text,
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
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: Strings.edit,
                    onPressed: _isDirty ? _onEditStaff : null,
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
