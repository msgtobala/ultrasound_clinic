import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/doctors/doctors_service.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/settings/add_doctor_form.dart';

class AddDoctorContainer extends StatefulWidget {
  const AddDoctorContainer({super.key});

  @override
  State<AddDoctorContainer> createState() => _AddDoctorContainerState();
}

class _AddDoctorContainerState extends State<AddDoctorContainer> {
  final DoctorService _doctorService = DoctorService();
  bool _isLoading = false;

  void addDoctor(Map<String, String> formData, File file) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    setState(() {
      _isLoading = true;
    });
    final response = await _doctorService.createDoctor(
      clinicId,
      formData,
      file,
    );
    setState(() {
      _isLoading = false;
    });
    if (response != null && response.isNotEmpty) {
      showSnackbar(context, Strings.doctorCreatedSuccessfully);
      Navigator.of(context).pop();
    } else {
      showSnackbar(context, Strings.doctorCreationFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddDoctorForm(
      isLoading: _isLoading,
      addDoctor: addDoctor,
    );
  }
}
