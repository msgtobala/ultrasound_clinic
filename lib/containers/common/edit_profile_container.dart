import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/edit_profile_form.dart';

class EditProfileContainer extends StatefulWidget {
  const EditProfileContainer({super.key});

  @override
  State<EditProfileContainer> createState() => _EditProfileContainerState();
}

class _EditProfileContainerState extends State<EditProfileContainer> {
  bool _isLoading = false;

  Future<void> onSaveUser(Map<String, String> data, File? profile) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    try {
      final isUpdated = await authProvider.saveUser(data, profile);
      showSnackbar(context, Strings.savedSuccessfully);
      setState(() {
        _isLoading = false;
      });
      if (isUpdated) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      showSnackbar(context, e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return EditProfileForm(
      isLoading: _isLoading,
      saveUser: onSaveUser,
    );
  }
}