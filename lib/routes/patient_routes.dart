import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/common/page_not_found.dart';
import 'package:ultrasound_clinic/screens/patient/clinic_selection_screen.dart';
import 'package:ultrasound_clinic/screens/common/home_navigation_screen.dart';

class PatientRoutes {
  const PatientRoutes._();

  static const String clinicSelection = '/clinic-selection';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> get buildPatientRoutes {
    return {
      clinicSelection: (context) => const ClinicSelectionScreen(),
      menu: (context) => const HomeNavigationMenu(),
    };
  }

  static String get initialPatientRoute {
    return PatientRoutes.menu;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundPage(),
      settings: settings,
    );
  }

  static final GlobalKey<NavigatorState> patientNavigatorKey =
      GlobalKey<NavigatorState>();
}
