import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/profile/profile_menu_list_item.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 5),
      child: Column(
        children: [
          ProfileMenuListItem(
            leading: Image.asset(Images.manageDoctorLogo),
            onTap: () {},
            trailing: Image.asset(Images.rightArrow),
            itemName: Strings.manageDoctor,
          ),
          ProfileMenuListItem(
            leading: Image.asset(Images.staff),
            onTap: () {},
            trailing: Image.asset(Images.rightArrow),
            itemName: Strings.manageStaff,
          ),
          ProfileMenuListItem(
            leading: Image.asset(Images.medicalRecord),
            onTap: () {},
            trailing: Image.asset(Images.rightArrow),
            itemName: Strings.usg,
          ),
          ProfileMenuListItem(
            leading: Image.asset(Images.password),
            onTap: () {},
            trailing: Image.asset(Images.rightArrow),
            itemName: Strings.password,
          ),
          ProfileMenuListItem(
            leading: Image.asset(Images.agreement),
            onTap: () {},
            trailing: Image.asset(Images.rightArrow),
            itemName: Strings.termsAndConditionsPascal,
          ),
        ],
      ),
    );
  }
}
