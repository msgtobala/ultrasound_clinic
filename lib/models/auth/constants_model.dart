import 'package:ultrasound_clinic/models/common/bottom_navigation_model.dart';
import 'package:ultrasound_clinic/models/common/settings_navigation_model.dart';

class ConstantsModel {
  final String loggedInStatusFlag;
  final List<BottomNavigationModel> bottomNavigation;
  final Map<String, String> formInputTypes;
  final List<String> sceneTypes;
  final int maxSceneTypes;
  final int appointmentTabs;
  final List<SettingsNavigationModel> clinicNavigationSettings;
  final List<SettingsNavigationModel> patientNavigationSettings;

  ConstantsModel({
    required this.loggedInStatusFlag,
    required this.bottomNavigation,
    required this.formInputTypes,
    required this.sceneTypes,
    required this.maxSceneTypes,
    required this.appointmentTabs,
    required this.clinicNavigationSettings,
    required this.patientNavigationSettings,
  });

  // Factory method to create a ConstantsModel from a map
  factory ConstantsModel.fromMap(Map<String, dynamic> map) {
    return ConstantsModel(
      loggedInStatusFlag: map['loggedInStatusFlag'] as String,
      bottomNavigation: map['bottomNavigation'] as List<BottomNavigationModel>,
      formInputTypes: map['formInputTypes'] as Map<String, String>,
      sceneTypes: map['sceneTypes'] as List<String>,
      maxSceneTypes: map['maxSceneTypes'] as int,
      appointmentTabs: map['appointmentTabs'] as int,
      clinicNavigationSettings:
          map['clinicNavigationSettings'] as List<SettingsNavigationModel>,
      patientNavigationSettings:
          map['patientNavigationSettings'] as List<SettingsNavigationModel>,
    );
  }
}
