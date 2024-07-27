import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/constants/enums/role_enum.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/clinic/appointments_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/panorama_media_screen.dart';
import 'package:ultrasound_clinic/screens/common/settings_screen.dart';
import 'package:ultrasound_clinic/screens/patient/panorama_viewer_screen.dart';
import 'package:ultrasound_clinic/screens/clinic/usg_report_screen.dart';
import 'package:ultrasound_clinic/screens/patient/appointment_form_screen.dart';
import 'package:ultrasound_clinic/screens/patient/usg_form_screen.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_intro.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';
import 'package:ultrasound_clinic/widgets/common/custom_bottom_navigation.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar.dart';

const List<Widget> _clinicScreens = [
  USGReportScreen(),
  AppointmentsScreen(),
  PanoramaMediaScreen(),
  SettingsScreen(isClinic: true),
];

const List<Widget> _patientScreens = [
  USGFormScreen(),
  AppointmentFormScreen(),
  PanoramaViewerScreen(),
  SettingsScreen(isClinic: false),
];

const List<Widget?> _clinicHeader = [
  CustomAppBarIntro(),
  CustomAppBar(),
  CustomAppBar(),
  null,
];

const List<Widget?> _patientHeader = [
  CustomAppBarText(title: Strings.usgForm),
  CustomAppBarText(title: Strings.patientAppointment),
  null,
  null,
];

class HomeNavigationMenu extends StatefulWidget {
  const HomeNavigationMenu({super.key});

  @override
  State<HomeNavigationMenu> createState() => _HomeNavigationMenuState();
}

class _HomeNavigationMenuState extends State<HomeNavigationMenu> {
  int _selectedIndex = 2;

  void _onNavigationChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final role = authProvider.currentUser!.role;

    Widget? appBar;
    if (role == UserRoleEnum.clinic.roleName) {
      appBar = _clinicHeader[_selectedIndex];
    } else {
      appBar = _patientHeader[_selectedIndex];
    }

    Widget content = role == UserRoleEnum.clinic.roleName
        ? _clinicScreens[_selectedIndex]
        : _patientScreens[_selectedIndex];

    if (kIsWeb) {
      content = Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: content,
        ),
      );
    }

    return Scaffold(
      appBar: appBar != null
          ? appBar as PreferredSizeWidget
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: content,
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onNavigationChanged: _onNavigationChanged,
      ),
    );
  }
}
