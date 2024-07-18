class SettingsNavigationModel {
  final String leading;
  final String trailing;
  final String iconName;
  final String route;

  SettingsNavigationModel({
    required this.leading,
    required this.trailing,
    required this.iconName,
    required this.route,
  });

  Map<String, dynamic> toJson() {
    return {
      'leading': leading,
      'trailing': trailing,
      'iconName': iconName,
    };
  }

  factory SettingsNavigationModel.fromJson(Map<String, dynamic> json) {
    return SettingsNavigationModel(
      iconName: json['iconName'],
      leading: json['leading'],
      trailing: json['trailing'],
      route: json['route'],
    );
  }
}
