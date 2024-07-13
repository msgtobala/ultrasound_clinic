import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/clinic/clinic_selection_screen.dart';
import 'package:ultrasound_clinic/screens/patient/patient_appointment_screen.dart';
import 'package:ultrasound_clinic/screens/patient/usg_screen.dart';

class PatientRoutes {
  const PatientRoutes._();

  static const String clinicSelection = '/clinic-selection';
  static const String patientAppointment = '/patient-appointment';
  static const String usgFormScreen = '/usg-form-screen';

  static Map<String, WidgetBuilder> get buildPatientRoutes {
    return {
      clinicSelection: (context) => const ClinicSelectionScreen(),
      patientAppointment: (context) => const PatientAppointmentScreen(),
      usgFormScreen: (context) => const UsgScreen(),
    };
  }

  static String get initialPatientRoute {
    return PatientRoutes.patientAppointment;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ClinicSelectionScreen(),
      settings: settings,
    );
  }
}
