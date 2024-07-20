import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/widgets/signup/my_appointments.dart';

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
  void initState() {
    super.initState();
    // fetchAppointmentByDate();
  }

  void fetchAppointmentByDate() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;

    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppointments(
      isLoading: _isLoading,
      appointments: _appointments,
    );
  }
}
