import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/user_profile.dart';
import 'package:ultrasound_clinic/widgets/common/user_profile_controls.dart';

class ClinicSettingsScreen extends StatelessWidget {
  const ClinicSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      pageTitle: '',
      pageDescription: '',
      hideMeta: true,
      offset: Offset(0, -(MediaQuery.of(context).padding.top + 300.h)),
      child: Padding(
        padding: EdgeInsets.all(20.s),
        child: Column(
          children: [
            const ClinicProfile(),
            SizedBox(height: 90.h),
            const UserProfileControls(),
          ],
        ),
      ),
    );
  }
}
