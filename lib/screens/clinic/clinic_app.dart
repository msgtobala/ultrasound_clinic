import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/themes/themes.dart';

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Themes.buildLightTheme(context),
        initialRoute: ClinicRoutes.initialClinicRoute,
        routes: ClinicRoutes.buildClinicRoutes,
        onUnknownRoute: ClinicRoutes.unknownRoute,
        navigatorObservers: [ClinicRoutes.routeObserver]);
  }
}
