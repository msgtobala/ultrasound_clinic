import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/screens/clinic/manage_appointments_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/manage_doctors_list_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/manage_staff_list_screen.dart';

class ClinicRoutes {
  const ClinicRoutes._();

  static const String initScreen = '/';
  static const String manageAppointments = 'manage-appointments';
  static const String manageDoctors = 'manage-doctors';
  static const String manageStaffs = 'manage-staffs';

  static Map<String, WidgetBuilder> get buildClinicRoutes {
    return {
      initScreen: (context) => const Text('Clinic'),
      manageAppointments: (context) => const ManageAppointmentsScreen(),
      manageDoctors: (context) => const ManageDoctorsListScreen(),
      manageStaffs: (context) => const ManageStaffListScreen()
    };
  }

  static String get initialClinicRoute {
    return ClinicRoutes.manageDoctors;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const Text(''),
      settings: settings,
    );
  }
}
