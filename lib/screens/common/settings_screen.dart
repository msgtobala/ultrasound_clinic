import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/user_profile.dart';
import 'package:ultrasound_clinic/widgets/common/user_profile_controls.dart';

class SettingsScreen extends StatefulWidget {
  final bool isClinic;

  const SettingsScreen({super.key, required this.isClinic});

  @override
  State<SettingsScreen> createState() => _ClinicSettingsScreenState();
}

class _ClinicSettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.frameBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: UserProfileCard(isClinic: widget.isClinic),
        ),
        UserProfileControls(isClinic: widget.isClinic),
      ],
    );
  }
}
