import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/screens/home.dart';

import 'package:ultrasound_clinic/screens/login_screen.dart';

class Routes {
  const Routes._();

  // login
  static const String login = '/login';

  // home
  static const String home = '/';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      login: (context) => const LoginScreen(),
      home: (context) => const HomeScreen(),
    };
  }

  static String get initialRoute {
    return Routes.login;
  }
}
