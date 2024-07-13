import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/screens/common/home_navigation.dart';

class ClinicRoutes {
  const ClinicRoutes._();

  static const String menu = '/menu';

  static Map<String, WidgetBuilder> get buildClinicRoutes {
    return {
      menu: (context) => const NavigationMenu(),
    };
  }

  static String get initialClinicRoute {
    return ClinicRoutes.menu;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const Text(''),
      settings: settings,
    );
  }
}
