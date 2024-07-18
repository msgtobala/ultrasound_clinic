import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/models/auth/user_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/models/common/form_model.dart';
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/regex.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class EditProfileForm extends StatefulWidget {
  final bool isLoading;
  final void Function(Map<String, String> data, File? profile) saveUser;

  const EditProfileForm({
    super.key,
    required this.isLoading,
    required this.saveUser,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  UserModel? currentUser;
  File? _selectedImage;

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {
    'name': '',
    'phone': '',
    'address': '',
    'city': '',
    'state': '',
  };
  final List<FormModel> formInputs = [
    FormModel(
      label: Strings.fullName,
      type: 'text',
      key: 'name',
      keyboardType: TextInputType.name,
    ),
    FormModel(
      label: Strings.email,
      type: 'text',
      key: 'email',
      keyboardType: TextInputType.emailAddress,
    ),
    FormModel(
      label: Strings.mobileNumber,
      type: 'text',
      key: 'phone',
      keyboardType: TextInputType.phone,
    ),
    FormModel(
      label: Strings.address,
      type: 'text',
      key: 'address',
      keyboardType: TextInputType.name,
    ),
    FormModel(
      label: 'Next',
      type: 'next',
      key: 'next',
      next: [
        FormModel(type: 'text', label: Strings.city, key: 'city'),
        FormModel(type: 'text', label: Strings.state, key: 'state'),
      ],
    ),
  ];
  void _onSaveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.saveUser(formData, _selectedImage);
    }
  }

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

    if (key == 'city' && (value == null || value.isEmpty)) {
      return Strings.invalidCity;
    }

    return null;
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final currentUser = authProvider.currentUser!;
    final String src = currentUser.profileUrl ?? '';

    return Column(
      mainAxisSize: MainAxisSize.max,
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
                    child: CircleAvatar(
                      backgroundColor: ThemeColors.white,
                      //Todo(should add custom widget for empty image)
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : src.isNotEmpty
                              ? NetworkImage(src)
                              : null,
                      radius: 50.d,
                      child: InkWell(
                        onTap: selectImage,
                        child: SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: const SVGLoader(image: icons.Icons.edit),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).padding.top + 20.hs),
              left: 30.vs,
              child: InkWell(
                onTap: goBack,
                child: SizedBox(
                  width: 15.w,
                  height: 15.h,
                  child: const SVGLoader(image: icons.Icons.back),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.hs, vertical: 20.vs),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ...formInputs.map((input) {
                      if (input.type == 'text') {
                        return Column(
                          key: Key(input.label),
                          children: [
                            FormInput(
                              initialValue: currentUser.toMap()[input.key],
                              text: input.label,
                              readOnly: input.key == 'email',
                              onSaved: (value) => _onSaved(input.key, value),
                              validator: (value) =>
                                  validator(input.key, value!),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      child: FormInput(
                                        initialValue:
                                            currentUser.toMap()[nextInput.key],
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

                      return const SizedBox();
                    }),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        text: Strings.submit,
                        onPressed: _onSaveProfile,
                        isLoading: widget.isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
