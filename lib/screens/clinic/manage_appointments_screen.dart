import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/containers/manage_appointments/manage_appointments_container.dart';

class ManageAppointmentsScreen extends StatelessWidget {
  const ManageAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ManageAppointmentsContainer(),
        ),
      ),
    );
  }
}
