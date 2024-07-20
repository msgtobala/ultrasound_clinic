import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/widgets/appointments/appointment_list.dart';

class MyAppointmentsContainer extends StatefulWidget {
  const MyAppointmentsContainer({super.key});

  @override
  State<MyAppointmentsContainer> createState() =>
      _MyAppointmentsContainerState();
}

class _MyAppointmentsContainerState extends State<MyAppointmentsContainer> {
  bool _isLoading = false;
  List<AppointmentModel> _appointments = [];

  @override
  Widget build(BuildContext context) {
    return AppointmentList(
      isLoading: _isLoading,
      appointments: _appointments,
    );
  }
}
