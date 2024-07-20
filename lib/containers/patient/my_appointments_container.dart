import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/appointments/appointments_service.dart';
import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/widgets/settings/my_appointments.dart';

class MyAppointmentsContainer extends StatefulWidget {
  const MyAppointmentsContainer({super.key});

  @override
  State<MyAppointmentsContainer> createState() =>
      _MyAppointmentsContainerState();
}

class _MyAppointmentsContainerState extends State<MyAppointmentsContainer> {
  final AppointmentsService appointmentsService = AppointmentsService();
  bool _isLoading = false;
  List<UserAppointmentModel> _appointments = [];
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchAppointmentByDate(currentDate);
  }

  void fetchAppointmentByDate(DateTime date) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser!.uid;

    setState(() {
      _isLoading = true;
    });

    final response = await appointmentsService.getUserAppointmentsByDate(
      userId,
      date,
    );
    setState(() {
      _isLoading = false;
      _appointments = response;
    });
  }

  void showDateDialog() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        currentDate = date;
      });
      fetchAppointmentByDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyAppointments(
      isLoading: _isLoading,
      appointments: _appointments,
      onTap: showDateDialog,
      date: currentDate,
    );
  }
}
