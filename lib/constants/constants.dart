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
  'carouselItems': [
    CarouselModel(
      image:
          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      label: 'Reception',
    ),
    CarouselModel(
      image:
          'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      label: 'Doctor room',
    ),
  ],
};

final constants = ConstantsModel.fromMap(constantsMap);
