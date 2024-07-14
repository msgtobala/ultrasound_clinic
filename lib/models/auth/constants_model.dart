import 'package:ultrasound_clinic/models/common/bottom_navigation_model.dart';
import 'package:ultrasound_clinic/models/common/carousel_model.dart';

class ConstantsModel {
  final String loggedInStatusFlag;
  final List<BottomNavigationModel> bottomNavigation;
  final List<CarouselModel> carouselItems;
  final Map<String, String> formInputTypes;

  ConstantsModel({
    required this.loggedInStatusFlag,
    required this.bottomNavigation,
    required this.carouselItems,
    required this.formInputTypes,
  });

  // Factory method to create a ConstantsModel from a map
  factory ConstantsModel.fromMap(Map<String, dynamic> map) {
    return ConstantsModel(
      loggedInStatusFlag: map['loggedInStatusFlag'] as String,
      bottomNavigation: map['bottomNavigation'] as List<BottomNavigationModel>,
      carouselItems: map['carouselItems'] as List<CarouselModel>,
      formInputTypes: map['formInputTypes'] as Map<String, String>,
    );
  }
}
