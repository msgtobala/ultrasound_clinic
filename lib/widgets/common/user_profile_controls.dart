import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/containers/auth/login/logout_container.dart';
import 'package:ultrasound_clinic/models/common/settings_navigation_model.dart';

import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/profile_menu_list_item.dart';

class UserProfileControls extends StatelessWidget {
  final bool isClinic;

  const UserProfileControls({super.key, required this.isClinic});

  void navigateTo(String route, BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final List<SettingsNavigationModel> settingsNavigation = isClinic
        ? constants.clinicNavigationSettings
        : constants.patientNavigationSettings;
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...settingsNavigation.map(
            (setting) => ProfileMenuListItem(
              itemName: setting.iconName,
              leading: Image.asset(
                setting.leading,
                width: 30.w,
                height: 30.h,
              ),
              trailing: Image.asset(setting.trailing),
              onTap: () => navigateTo(setting.route, context),
            ),
          ),
          SizedBox(height: 20.h),
          const LogoutContainer(),
        ],
      ),
    );
  }
}
