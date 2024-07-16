import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/appointments/appointment_list.dart';

class TodaysAppointmentsContainer extends StatefulWidget {
  const TodaysAppointmentsContainer({super.key});

  @override
  State<TodaysAppointmentsContainer> createState() =>
      _TodaysAppointmentsContainerState();
}

class _TodaysAppointmentsContainerState
    extends State<TodaysAppointmentsContainer> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppointmentList(isLoading: _isLoading);
  }
}
