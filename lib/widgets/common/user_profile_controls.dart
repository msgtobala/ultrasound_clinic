import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/profile_menu_list_item.dart';

class UserProfileControls extends StatelessWidget {
  const UserProfileControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        children: [
          ProfileMenuListItem(
            onTap: () {},
            leading: Image.asset(
              icons.Icons.manageDoctor,
              width: 34,
              height: 34,
            ),
            trailing: Image.asset(icons.Icons.rightArrow),
            itemName: Strings.manageDoctor,
          ),
          ProfileMenuListItem(
            leading: Image.asset(
              icons.Icons.manageStaff,
              width: 34,
              height: 34,
            ),
            onTap: () {},
            trailing: Image.asset(icons.Icons.rightArrow),
            itemName: Strings.manageStaff,
          ),
          ProfileMenuListItem(
            leading: Image.asset(
              icons.Icons.manageUSG,
              width: 34,
              height: 34,
            ),
            onTap: () {},
            trailing: Image.asset(icons.Icons.rightArrow),
            itemName: Strings.usg,
          ),
          ProfileMenuListItem(
            leading: Image.asset(
              icons.Icons.changePassword,
              width: 34,
              height: 34,
            ),
            onTap: () {},
            trailing: Image.asset(icons.Icons.rightArrow),
            itemName: Strings.password,
          ),
          ProfileMenuListItem(
            leading: Image.asset(
              icons.Icons.termsAndConditions,
              width: 34,
              height: 34,
            ),
            onTap: () {},
            trailing: Image.asset(icons.Icons.rightArrow),
            itemName: Strings.termsAndConditions,
          ),
        ],
      ),
    );
  }
}
