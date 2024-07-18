import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/auth/constants_model.dart';
import 'package:ultrasound_clinic/models/common/bottom_navigation_model.dart';
import 'package:ultrasound_clinic/models/common/settings_navigation_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';

final constantsMap = {
  'loggedInStatusFlag': 'loggedInStatusFlag',
  'bottomNavigation': [
    BottomNavigationModel(
      label: Strings.usg,
      icon: icons.Icons.usg,
      activeIcon: icons.Icons.usgActive,
      width: 24,
      height: 24,
    ),
    BottomNavigationModel(
      label: Strings.appointments,
      icon: icons.Icons.appointment,
      activeIcon: icons.Icons.appointmentActive,
      width: 24,
      height: 24,
    ),
    BottomNavigationModel(
      label: Strings.media,
      icon: icons.Icons.media,
      activeIcon: icons.Icons.mediaActive,
      width: 36,
      height: 28,
    ),
    BottomNavigationModel(
      label: Strings.settings,
      icon: icons.Icons.settings,
      activeIcon: icons.Icons.settingsActive,
      width: 24,
      height: 24,
    ),
  ],
  'formInputTypes': {
    'text': 'text',
  },
  'sceneTypes': [
    'Front',
    'Reception',
    'Doctor Room',
    'Ultrasound Machine',
    'Waiting Room',
    'Rest Room',
  ],
  'maxSceneTypes': 6,
  'appointmentTabs': 2,
  'clinicNavigationSettings': [
    SettingsNavigationModel(
      iconName: Strings.manageDoctor,
      leading: icons.Icons.manageDoctor,
      trailing: icons.Icons.rightArrow,
      route: ClinicRoutes.addAndEditDoctor,
    ),
    SettingsNavigationModel(
      iconName: Strings.manageStaff,
      leading: icons.Icons.manageStaff,
      trailing: icons.Icons.rightArrow,
      route: ClinicRoutes.addAndEditStaff,
    ),
    SettingsNavigationModel(
      iconName: Strings.changePassword,
      leading: icons.Icons.changePassword,
      trailing: icons.Icons.rightArrow,
      route: '/manage-staff',
    ),
    SettingsNavigationModel(
      iconName: Strings.termsAndConditions,
      leading: icons.Icons.termsAndConditions,
      trailing: icons.Icons.rightArrow,
      route: '/manage-staff',
    ),
  ],
  'patientNavigationSettings': [
    SettingsNavigationModel(
      iconName: Strings.myAppointments,
      leading: icons.Icons.manageAppointments,
      trailing: icons.Icons.rightArrow,
      route: '/manage-staff',
    ),
    SettingsNavigationModel(
      iconName: Strings.knowYourDoctor,
      leading: icons.Icons.manageDoctor,
      trailing: icons.Icons.rightArrow,
      route: '/manage-staff',
    ),
    SettingsNavigationModel(
      iconName: Strings.staffList,
      leading: icons.Icons.manageStaff,
      trailing: icons.Icons.rightArrow,
      route: '/manage-staff',
    ),
    SettingsNavigationModel(
      iconName: Strings.changePassword,
      leading: icons.Icons.changePassword,
      trailing: icons.Icons.rightArrow,
      route: '/manage-staff',
    ),
    SettingsNavigationModel(
      iconName: Strings.termsAndConditions,
      leading: icons.Icons.termsAndConditions,
      trailing: icons.Icons.rightArrow,
      route: '/manage-staff',
    ),
  ],
  'doctorDegrees': [
    const DropdownMenuEntry(value: 'MDRD', label: 'MDRD'),
    const DropdownMenuEntry(value: 'DMRD', label: 'DMRD'),
    const DropdownMenuEntry(value: 'DNBRD', label: 'DNBRD'),
    const DropdownMenuEntry(value: 'MS', label: 'MS'),
    const DropdownMenuEntry(value: 'MD', label: 'MD'),
    const DropdownMenuEntry(value: 'DNB', label: 'DNB'),
    const DropdownMenuEntry(value: 'MBBS', label: 'MBBS'),
  ],
  'staffDesignations': [
    const DropdownMenuEntry(value: 'Receptionist', label: 'Receptionist'),
    const DropdownMenuEntry(value: 'Typist', label: 'Typist'),
    const DropdownMenuEntry(value: 'Helper', label: 'Helper'),
    const DropdownMenuEntry(value: 'Sweeper', label: 'Sweeper'),
    const DropdownMenuEntry(value: 'Nurse', label: 'Nurse'),
  ],
};

final constants = ConstantsModel.fromMap(constantsMap);
