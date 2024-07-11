import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/auth/init_screen.dart';
import 'package:ultrasound_clinic/screens/auth/login_screen.dart';

class Routes {
  const Routes._();

  // auth
  static const String initScreen = '/';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      initScreen: (context) => const InitScreen(),
    };
  }

  static String get initialRoute {
    return Routes.initScreen;
  }

  static Widget get initialScreen {
    return const InitScreen();
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
      settings: settings,
    );
  }
}
