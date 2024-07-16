import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/appointments/appointment_card.dart';

class AppointmentList extends StatelessWidget {
  final bool isLoading;

  const AppointmentList({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration
    final List<Map<String, String>> todayAppointments = [
      {
        "name": "Raji",
        "appointmentId": "369525658",
        "appointmentTime": "10:00 AM - 26-July-2024",
        "imageUrl": "",
      },
      {
        "name": "Balaji",
        "appointmentId": "369525659",
        "appointmentTime": "10:00 AM - 26-July-2024",
        "imageUrl": "",
      },
    ];

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: todayAppointments.length,
      itemBuilder: (context, index) {
        final appointment = todayAppointments[index];
        return AppointmentCard(
          name: appointment["name"]!,
          appointmentId: appointment["appointmentId"]!,
          appointmentTime: appointment["appointmentTime"]!,
          imageUrl: appointment["imageUrl"]!,
        );
      },
    );
  }
}
