import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/auth/change_password_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/add_acknowlegde_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/add_staff_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/edit_doctor_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/edit_staff_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/view_assets_screen.dart';
import 'package:ultrasound_clinic/screens/common/doctors_list_screen.dart';
import 'package:ultrasound_clinic/screens/common/edit_profile_screen.dart';
import 'package:ultrasound_clinic/screens/common/home_navigation_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/panorama_previewer_screen.dart';
import 'package:ultrasound_clinic/screens/common/page_not_found.dart';
import 'package:ultrasound_clinic/screens/clinic/add_doctor_screen.dart';
import 'package:ultrasound_clinic/screens/common/staff_list_screen.dart';
import 'package:ultrasound_clinic/screens/common/terms_and_conditions.dart';

class ClinicRoutes {
  const ClinicRoutes._();

  static const String menu = '/menu';
  static const String panoramaPreviewer = '/panorama-previewer';
  static const String editProfile = '/edit-profile';
  static const String viewAssets = '/view-assets';
  static const String addDoctor = '/add-doctor';
  static const String editDoctor = '/edit-doctor';
  static const String addStaff = '/add-staff';
  static const String editStaff = '/edit-list';
  static const String doctorList = '/doctor-list';
  static const String staffList = '/staff-list';
  static const String termAndConditions = '/term-and-conditions';
  static const String changePassword = '/change-password';
  static const String addAcknowledge = '/add-acknowledge';

  static Map<String, WidgetBuilder> get buildClinicRoutes {
    return {
      menu: (context) => const HomeNavigationMenu(),
      panoramaPreviewer: (context) => const PanoramaPreviewerScreen(),
      editProfile: (context) => const EditProfileScreen(),
      viewAssets: (context) => const ViewAssetsScreen(),
      addDoctor: (context) => const AddDoctorScreen(),
      addStaff: (context) => const AddStaffScreen(),
      editStaff: (context) => const EditStaffScreen(),
      doctorList: (context) => const DoctorsListScreen(),
      staffList: (context) => const StaffListScreen(),
      editDoctor: (context) => const EditDoctorScreen(),
      termAndConditions: (context) => const TermsAndConditions(),
      changePassword: (context) => const ChangePasswordScreen(),
      addAcknowledge: (context) => const AddAcknowlegdeScreen(),
    };
  }

  static String get initialClinicRoute {
    return ClinicRoutes.menu;
  }

  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundPage(),
      settings: settings,
    );
  }
}
