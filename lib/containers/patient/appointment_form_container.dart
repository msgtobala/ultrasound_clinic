import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/core/services/appointments/appointments_service.dart';

import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/routes/patient_routes.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/appointment_form/appointment_form.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

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
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void onClose(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void showConfirmationPop(String appointmentId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.d),
          ),
          title: const Text(Strings.appointmentRequested),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Strings.yourAppointmentRequestHasBeenSubmitted),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      appointmentId,
                      style:
                          Theme.of(context).textTheme.headlineSmallRegularGrey,
                    ),
                  ),
                  IconButton(
                    icon: const SVGLoader(image: icons.Icons.copyBlack),
                    onPressed: () => onCopy(appointmentId),
                    color: ThemeColors.black,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => onClose(context),
              child: Text(Strings.close.toUpperCase()),
            ),
          ],
        );
      },
    );
  }

  Future<void> addAppointment(AppointmentInputModel appointment) async {
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
