class BottomNavigationModel {
  final String label;
  final String icon;
  final String activeIcon;
  final double width;
  final double height;

  BottomNavigationModel({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.width,
    required this.height,
  });

  // Factory method to create a BottomNavigationModel from a map
  factory BottomNavigationModel.fromMap(Map<String, dynamic> map) {
    return BottomNavigationModel(
      label: map['label'] as String,
      icon: map['icon'] as String,
      activeIcon: map['activeIcon'] as String,
      width: map['width'] as double,
      height: map['height'] as double,
    );
  }
}
