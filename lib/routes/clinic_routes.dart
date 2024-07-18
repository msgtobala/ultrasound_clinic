import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/screens/clinic/add_and_edit_staff_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/view_assets_screen.dart';
import 'package:ultrasound_clinic/screens/common/doctors_list_screen.dart';
import 'package:ultrasound_clinic/screens/common/edit_profile_screen.dart';
import 'package:ultrasound_clinic/screens/common/home_navigation_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/panorama_previewer_screen.dart';
import 'package:ultrasound_clinic/screens/common/page_not_found.dart';
import 'package:ultrasound_clinic/screens/clinic/add_and_edit_doctor_screen.dart';
import 'package:ultrasound_clinic/screens/common/staff_list_screen.dart';

class ClinicRoutes {
  const ClinicRoutes._();

  static const String menu = '/menu';
  static const String panoramaPreviewer = '/panorama-previewer';
  static const String editProfile = '/edit-profile';
  static const String viewAssets = '/view-assets';
  static const String addAndEditDoctor = '/add-and-edit-doctor';
  static const String addAndEditStaff = '/add-and-edit-staff';
  static const String doctorList = '/doctor-list';
  static const String staffList = '/staff-list';

  static Map<String, WidgetBuilder> get buildClinicRoutes {
    return {
      menu: (context) => const HomeNavigationMenu(),
      panoramaPreviewer: (context) => const PanoramaPreviewerScreen(),
      editProfile: (context) => const EditProfileScreen(),
      viewAssets: (context) => const ViewAssetsScreen(),
      addAndEditDoctor: (context) => const AddAndEditDoctorScreen(),
      addAndEditStaff: (context) => const AddAndEditStaffScreen(),
      doctorList: (context) => const DoctorsListScreen(),
      staffList: (context) => const StaffListScreen(),
    };
  }

  static String get initialClinicRoute {
    return ClinicRoutes.menu;
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundPage(),
      settings: settings,
    );
  }

  static final GlobalKey<NavigatorState> clinicNavigatorKey =
      GlobalKey<NavigatorState>();
}
