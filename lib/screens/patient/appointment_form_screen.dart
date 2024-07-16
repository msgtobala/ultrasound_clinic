import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/patient/appointment_form_container.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class AppointmentFormScreen extends StatelessWidget {
  const AppointmentFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: const AppointmentFormContainer(),
      ),
    );
  }
}
