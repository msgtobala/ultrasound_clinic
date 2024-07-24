import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/auth/change_password_screen.dart';
import 'package:ultrasound_clinic/screens/common/doctors_list_screen.dart';
import 'package:ultrasound_clinic/screens/common/edit_profile_screen.dart';
import 'package:ultrasound_clinic/screens/common/page_not_found.dart';
import 'package:ultrasound_clinic/screens/common/staff_list_screen.dart';
import 'package:ultrasound_clinic/screens/common/terms_and_conditions.dart';
import 'package:ultrasound_clinic/screens/patient/clinic_selection_screen.dart';
import 'package:ultrasound_clinic/screens/common/home_navigation_screen.dart';
import 'package:ultrasound_clinic/screens/patient/my_appointments_screen.dart';

class PatientRoutes {
  const PatientRoutes._();

  static const String clinicSelection = '/clinic-selection';
  static const String menu = '/menu';
  static const String myAppointments = '/my-appointments';
  static const String myUSGs = '/my-usgs';
  static const String doctorList = '/doctor-list';
  static const String staffList = '/staff-list';
  static const String termAndConditions = '/term-and-conditions';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';

  static Map<String, WidgetBuilder> get buildPatientRoutes {
    return {
      clinicSelection: (context) => const ClinicSelectionScreen(),
      menu: (context) => const HomeNavigationMenu(),
      doctorList: (context) => const DoctorsListScreen(),
      staffList: (context) => const StaffListScreen(),
      editProfile: (context) => const EditProfileScreen(),
      termAndConditions: (context) => const TermsAndConditions(),
      myAppointments: (context) => const MyAppointmentsScreen(),
      changePassword: (context) => const ChangePasswordScreen(),
    };
  }

  static String get initialPatientRoute {
    return PatientRoutes.clinicSelection;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundPage(),
      settings: settings,
    );
  }
}
