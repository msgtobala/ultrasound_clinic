import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/date_time/date_time.dart';

import 'package:ultrasound_clinic/widgets/appointments/appointment_card.dart';

class UserAppointmentList extends StatelessWidget {
  final bool isLoading;
  final List<UserAppointmentModel> userAppointments;

  const UserAppointmentList({
    super.key,
    required this.isLoading,
    required this.userAppointments,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (userAppointments.isEmpty) {
      return Center(
        child: Text(
          Strings.noAppointmentsFound,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    return ListView.builder(
      itemCount: userAppointments.length,
      itemBuilder: (context, index) {
        final appointment = userAppointments[index];
        return AppointmentCard(
          name: appointment.patientName,
          appointmentId: appointment.uid,
          appointmentTime: formatDateTime(appointment.date),
          imageUrl: '',
        );
      },
    );
  }
}
