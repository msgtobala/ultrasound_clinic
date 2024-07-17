import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/edit_profile_form.dart';

class EditProfileContainer extends StatefulWidget {
  const EditProfileContainer({super.key});

  @override
  State<EditProfileContainer> createState() => _EditProfileContainerState();
}

class _EditProfileContainerState extends State<EditProfileContainer> {
  bool _isLoading = false;

  Future<void> onSaveUser(Map<String, String> data) async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final isUpdated = await authProvider.saveUser(data);
      showSnackbar(context, "saved successfully");
      setState(() {
        _isLoading = false;
      });
      if (isUpdated) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
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
