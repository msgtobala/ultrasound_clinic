import 'package:ultrasound_clinic/models/auth/constants_model.dart';
import 'package:ultrasound_clinic/models/common/bottom_navigation_model.dart';
import 'package:ultrasound_clinic/models/common/carousel_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';

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
};

final constants = ConstantsModel.fromMap(constantsMap);
