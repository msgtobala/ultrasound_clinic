import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/staff/staff_service.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/settings/add_staff_form.dart';

class AddStaffContainer extends StatefulWidget {
  const AddStaffContainer({super.key});

  @override
  State<AddStaffContainer> createState() => _AddStaffContainerState();
}

class _AddStaffContainerState extends State<AddStaffContainer> {
  final StaffService _staffService = StaffService();
  bool _isLoading = false;

  void addStaff(Map<String, String> formData, File file) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    setState(() {
      _isLoading = true;
    });
    final response = await _staffService.createStaff(
      clinicId,
      formData,
      file,
    );
    setState(() {
      _isLoading = false;
    });
    if (response != null && response.isNotEmpty) {
      showSnackbar(context, Strings.staffCreatedSuccessfully);
      Navigator.of(context).pop();
    } else {
      showSnackbar(context, Strings.staffCreationFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddStaffForm(
      isLoading: _isLoading,
      addStaff: addStaff,
    );
  }
}
