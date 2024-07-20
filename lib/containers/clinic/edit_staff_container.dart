import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/staff/staff_service.dart';
import 'package:ultrasound_clinic/models/common/staff_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/edit_staff_form.dart';

class EditStaffContainer extends StatefulWidget {
  final StaffModel currentStaff;
  const EditStaffContainer({super.key, required this.currentStaff});

  @override
  State<EditStaffContainer> createState() => _EditStaffContainerState();
}

class _EditStaffContainerState extends State<EditStaffContainer> {
  final StaffService staffService = StaffService();
  bool _isLoading = false;

  void onEdit(String staffId, Map<String, String> formData, File? file) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;

    setState(() {
      _isLoading = true;
    });

    final response =
        await staffService.updateStaff(clinicId, staffId, formData, file);
    if (response) {
      showSnackbar(context, Strings.savedSuccessfully);
      Navigator.of(context).pop();
    } else {
      showSnackbar(context, Strings.failedToSave);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EditStaffForm(
      isLoading: _isLoading,
      currentStaff: widget.currentStaff,
      onEdit: onEdit,
    );
  }
}
