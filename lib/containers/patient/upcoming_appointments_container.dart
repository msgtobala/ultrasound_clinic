import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/appointments/appointment_list.dart';

class UpcomingAppointmentsContainer extends StatefulWidget {
  const UpcomingAppointmentsContainer({super.key});

  @override
  State<UpcomingAppointmentsContainer> createState() =>
      _UpcomingAppointmentsContainerState();
}

class _UpcomingAppointmentsContainerState
    extends State<UpcomingAppointmentsContainer> {
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
