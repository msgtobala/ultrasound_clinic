import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/appointments/appointments_service.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/appointment_form/appointment_form.dart';
import 'package:ultrasound_clinic/widgets/common/custom_info_dialog.dart';

class AppointmentFormContainer extends StatefulWidget {
  const AppointmentFormContainer({super.key});

  @override
  State<AppointmentFormContainer> createState() =>
      _AppointmentFormContainerState();
}

class _AppointmentFormContainerState extends State<AppointmentFormContainer> {
  final AppointmentsService appointmentService = AppointmentsService();

  bool _isLoading = false;

  void onCopy(String appointmentId) {
    Clipboard.setData(ClipboardData(text: appointmentId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(Strings.copiedToCLipboard)),
    );
  }

  void onClose(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void showConfirmationPop(String appointmentId) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomInfoDialog(
          title: Strings.appointmentRequested,
          content: Strings.yourAppointmentRequestHasBeenSubmitted,
          displayData: appointmentId,
          onClose: onClose,
          onCopy: onCopy,
        );
      },
    );
  }

  Future<void> addAppointment(Map<String, dynamic> appointment) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    final userId = authProvider.currentUser!.uid;

    setState(() {
      _isLoading = true;
    });

    final appointmentId = await appointmentService.createAppointment(
      clinicId,
      userId,
      appointment,
    );

    setState(() {
      _isLoading = false;
    });
    if (appointmentId != null) {
      showConfirmationPop(appointmentId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Strings.failedToCreateAppointment),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppointmentForm(
      isLoading: _isLoading,
      addAppointment: addAppointment,
    );
  }
}
