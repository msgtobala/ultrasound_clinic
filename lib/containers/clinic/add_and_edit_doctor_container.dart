import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/widgets/common/add_and_edit_doctor_form.dart';

class AddAndEditDoctorContainer extends StatelessWidget {
  const AddAndEditDoctorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddAndEditDoctorForm(
      isEdit: false,
    );
  }
}
