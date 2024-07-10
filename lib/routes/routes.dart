import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/init_screen.dart';
import 'package:ultrasound_clinic/screens/landing_screen.dart';
import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/screens/profile_screen.dart';
import 'package:ultrasound_clinic/screens/signup_screen.dart';
import 'package:ultrasound_clinic/screens/otp_verification_screen.dart';
import 'package:ultrasound_clinic/screens/clinic_code_screen.dart';
import 'package:ultrasound_clinic/screens/signup_successful_screen.dart';

class Routes {
  const Routes._();

  // auth
  static const String initScreen = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String verifyOTP = '/verifyOTP';
  static const String signUpSuccess = '/signUpSuccess';

  // clinic code
  static const String clinicCode = '/clinicCode';

  //profile
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      initScreen: (context) => const LandingScreen(),
      login: (context) => const LoginScreen(),
      signUp: (context) => const SignUpScreen(),
      verifyOTP: (context) => const OtpVerificationScreen(),
      clinicCode: (context) => const ClinicCodeScreen(),
      signUpSuccess: (context) => const SignupSuccessFulScreen(),
    };
  }

  static String get initialRoute {
    return Routes.verifyOTP;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
      settings: settings,
    );
  }
}
