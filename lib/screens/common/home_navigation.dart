import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/constants/enums/role_enum.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/screens/clinic/appointments.dart';
import 'package:ultrasound_clinic/screens/clinic/panorama_media.dart';
import 'package:ultrasound_clinic/screens/clinic/settings.dart'
    as clinic_settings;
import 'package:ultrasound_clinic/screens/patient/settings.dart'
    as patient_settings;
import 'package:ultrasound_clinic/screens/clinic/usg_report.dart';
import 'package:ultrasound_clinic/screens/patient/appointment_form.dart';
import 'package:ultrasound_clinic/screens/patient/panorama_media_viewer.dart';
import 'package:ultrasound_clinic/screens/patient/usg_form.dart';
import 'package:ultrasound_clinic/widgets/common/custom_bottom_navigation.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar.dart';

const List<Widget> _clinicScreens = [
  USGReport(),
  Appointments(),
  PanoramaMedia(),
  clinic_settings.Settings(),
];

const List<Widget> _patientScreens = [
  USGForm(),
  AppointmentForm(),
  PanoramaMediaViewer(),
  patient_settings.Settings(),
];

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
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

    return Scaffold(
      appBar: const CustomAppBar(),
      body: role == UserRoleEnum.clinic.roleName
          ? _clinicScreens[_selectedIndex]
          : _patientScreens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onNavigationChanged: _onNavigationChanged,
      ),
    );
  }
}
