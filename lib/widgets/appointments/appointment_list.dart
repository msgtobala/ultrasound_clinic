import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/date_time/date_time.dart';
import 'package:ultrasound_clinic/widgets/appointments/appointment_card.dart';
import 'package:ultrasound_clinic/widgets/common/custom_shimmer/custom_card_shimmer.dart';

class AppointmentList extends StatelessWidget {
  final bool isLoading;
  final List<AppointmentModel> appointments;

  const AppointmentList({
    super.key,
    required this.isLoading,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CustomCardShimmer();
    }

    if (appointments.isEmpty) {
      return Center(
        child: Text(
          Strings.noAppointmentsFound,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
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
