import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/widgets/appointments/appointment_list.dart';

class MyAppointments extends StatelessWidget {
  final bool isLoading;
  final List<AppointmentModel> appointments;

  const MyAppointments({
    super.key,
    required this.isLoading,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return AppointmentList(
      isLoading: isLoading,
      appointments: appointments,
    );
  }
}
