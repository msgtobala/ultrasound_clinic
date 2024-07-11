import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/init_screen.dart';
import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/screens/signup_screen.dart';
import 'package:ultrasound_clinic/screens/otp_verification_screen.dart';
import 'package:ultrasound_clinic/screens/clinic_code_screen.dart';
import 'package:ultrasound_clinic/screens/signup_successful_screen.dart';
import 'package:ultrasound_clinic/screens/setting_screen.dart';
import 'package:ultrasound_clinic/screens/doctor_list.dart';
import 'package:ultrasound_clinic/screens/add_doctor.dart';

class Routes {
  const Routes._();

  // auth
  static const String initScreen = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String verifyOTP = '/verifyOTP';
  static const String signUpSuccess = '/signUpSuccess';
  static const String setting = '/setting';
    static const String doctorSetting = '/doctorSetting';
        static const String addDoctor = '/addDoctor';

  // clinic code
  static const String clinicCode = '/clinicCode';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      initScreen: (context) => const InitScreen(),
      login: (context) => const LoginScreen(),
      signUp: (context) => const SignUpScreen(),
      verifyOTP: (context) => const OtpVerificationScreen(),
      clinicCode: (context) => const ClinicCodeScreen(),
      signUpSuccess: (context) => const SignupSuccessFulScreen(),
      setting: (context) => const ClinicManagementScreen(),
      doctorSetting: (context) => const DoctorListScreen(),
      addDoctor: (context) => const AddDoctorScreen(),
    };
  }

  static String get initialRoute {
    return Routes.initScreen;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
      settings: settings,
    );
  }
}
