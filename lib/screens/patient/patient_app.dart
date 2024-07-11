import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/routes/patient_routes.dart';
import 'package:ultrasound_clinic/themes/themes.dart';

class PatientApp extends StatelessWidget {
  const PatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.buildLightTheme(context),
      initialRoute: PatientRoutes.initialPatientRoute,
      routes: PatientRoutes.buildPatientRoutes,
      onUnknownRoute: PatientRoutes.unknownRoute,
    );
  }
}
