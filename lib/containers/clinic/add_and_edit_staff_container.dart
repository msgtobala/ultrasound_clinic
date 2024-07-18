import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/staff/staff_service.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/settings/add_and_edit_staff_form.dart';

class AddAndEditStaffContainer extends StatefulWidget {
  const AddAndEditStaffContainer({super.key});

  @override
  State<AddAndEditStaffContainer> createState() =>
      _AddAndEditStaffContainerState();
}

class _AddAndEditStaffContainerState extends State<AddAndEditStaffContainer> {
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
    return AddAndEditStaffForm(
      isEdit: false,
      isLoading: _isLoading,
      addStaff: addStaff,
    );
  }
}
