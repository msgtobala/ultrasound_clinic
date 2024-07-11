import 'package:flutter/material.dart';

class ClinicRoutes {
  const ClinicRoutes._();

  static const String initScreen = '/';

  static Map<String, WidgetBuilder> get buildClinicRoutes {
    return {
      initScreen: (context) => const Text('Clinic'),
    };
  }

  static String get initialClinicRoute {
    return ClinicRoutes.initScreen;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const Text(''),
      settings: settings,
    );
  }
}
