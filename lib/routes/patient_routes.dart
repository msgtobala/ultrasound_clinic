import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/clinic/clinic_selection_screen.dart';

class PatientRoutes {
  const PatientRoutes._();

  static const String clinicSelection = '/clinic-selection';

  static Map<String, WidgetBuilder> get buildPatientRoutes {
    return {
      clinicSelection: (context) => const ClinicSelectionScreen(),
    };
  }

  static String get initialPatientRoute {
    return PatientRoutes.clinicSelection;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ClinicSelectionScreen(),
      settings: settings,
    );
  }
}
