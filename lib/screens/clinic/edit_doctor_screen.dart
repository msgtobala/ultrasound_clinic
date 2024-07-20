import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/clinic/edit_doctor_container.dart';
import 'package:ultrasound_clinic/models/common/doctor_model.dart';

class EditDoctorScreen extends StatelessWidget {
  const EditDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorModel currentDoctor =
        ModalRoute.of(context)!.settings.arguments as DoctorModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: EditDoctorContainer(
          currentDoctor: currentDoctor,
        ),
      ),
    );
  }
}
