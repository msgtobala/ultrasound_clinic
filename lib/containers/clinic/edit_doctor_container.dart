import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/doctors/doctors_service.dart';
import 'package:ultrasound_clinic/models/common/doctor_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/edit_doctor_form.dart';

class EditDoctorContainer extends StatefulWidget {
  final DoctorModel currentDoctor;
  const EditDoctorContainer({super.key, required this.currentDoctor});

  @override
  State<EditDoctorContainer> createState() => _EditDoctorContainerState();
}

class _EditDoctorContainerState extends State<EditDoctorContainer> {
  final DoctorService doctorService = DoctorService();
  bool _isLoading = false;

  void onEdit(String doctorId, Map<String, String> formData, File? file) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;

    setState(() {
      _isLoading = true;
    });

    final response =
        await doctorService.updateDoctor(clinicId, doctorId, formData, file);
    if (response) {
      showSnackbar(context, Strings.savedSuccessfully);
      Navigator.of(context).pop();
    } else {
      showSnackbar(context, Strings.failedToSave);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EditDoctorForm(
      isLoading: _isLoading,
      currentDoctor: widget.currentDoctor,
      onEdit: onEdit,
    );
  }
}
