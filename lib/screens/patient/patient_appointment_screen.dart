import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/patient_appointment/patient_appointment_container.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class PatientAppointmentScreen extends StatelessWidget {
  const PatientAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              Strings.patientAppointment,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 42.h,
            ),
            const PatientAppointmentContainer()
          ],
        ),
      ),
    );
  }
}
