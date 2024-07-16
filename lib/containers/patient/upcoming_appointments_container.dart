import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/appointments/appointments_service.dart';
import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/widgets/appointments/appointment_list.dart';

class UpcomingAppointmentsContainer extends StatefulWidget {
  const UpcomingAppointmentsContainer({super.key});

  @override
  State<UpcomingAppointmentsContainer> createState() =>
      _UpcomingAppointmentsContainerState();
}

class _UpcomingAppointmentsContainerState
    extends State<UpcomingAppointmentsContainer> {
  final AppointmentsService appointmentsService = AppointmentsService();
  bool _isLoading = true;
  List<AppointmentModel> _appointments = [];

  void fetchUpcomingAppointments() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser?.clinics.first ?? '';

    if (clinicId.isEmpty) {
      return;
    }

    final response =
        await appointmentsService.getUpcomingAppointments(clinicId);

    setState(() {
      _isLoading = false;
      _appointments = response;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchUpcomingAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return AppointmentList(
      isLoading: _isLoading,
      appointments: _appointments,
    );
  }
}
