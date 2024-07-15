import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/appointments/appointment_card.dart';

class AppointmentList extends StatelessWidget {
  const AppointmentList({super.key, required this.tab});

  final String tab;

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
      // Add more appointments as needed
    ];
    final List<Map<String, String>> upcomingAppointments = [
      {
        "name": "Person-1",
        "appointmentId": "369525658",
        "appointmentTime": "10:00 AM - 26-July-2024",
        "imageUrl": "",
      },
      {
        "name": "Person-2",
        "appointmentId": "369525659",
        "appointmentTime": "10:00 AM - 26-July-2024",
        "imageUrl": "",
      },
      // Add more appointments as needed
    ];
    if (tab == Strings.upcoming) {
      return ListView.builder(
        itemCount: upcomingAppointments.length,
        itemBuilder: (context, index) {
          final appointment = upcomingAppointments[index];
          return AppointmentCard(
            name: appointment["name"]!,
            appointmentId: appointment["appointmentId"]!,
            appointmentTime: appointment["appointmentTime"]!,
            imageUrl: appointment["imageUrl"]!,
          );
        },
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
