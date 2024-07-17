import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/common/home_navigation_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/panorama_previewer_screen.dart';

class ClinicRoutes {
  const ClinicRoutes._();

  static const String menu = '/menu';
  static const String panoramaPreviewer = '/panorama-previewer';
  static const String viewAssets = '/view-assets';

  static Map<String, WidgetBuilder> get buildClinicRoutes {
    return {
      menu: (context) => const HomeNavigationMenu(),
      panoramaPreviewer: (context) => const PanoramaPreviewerScreen(),
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

  static final GlobalKey<NavigatorState> clinicNavigatorKey =
      GlobalKey<NavigatorState>();
}
