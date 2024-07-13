import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/patient/clinic_selection_screen.dart';
import 'package:ultrasound_clinic/screens/common/home_navigation.dart';

class PatientRoutes {
  const PatientRoutes._();

  static const String clinicSelection = '/clinic-selection';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> get buildPatientRoutes {
    return {
      clinicSelection: (context) => const ClinicSelectionScreen(),
      menu: (context) => const NavigationMenu(),
    };
  }

  static String get initialPatientRoute {
    return PatientRoutes.menu;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ClinicSelectionScreen(),
      settings: settings,
    );
  }
}
