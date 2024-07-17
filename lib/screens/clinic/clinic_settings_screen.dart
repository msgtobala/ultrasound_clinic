import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/auth/landing_screen.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_outlined_button.dart';
import 'package:ultrasound_clinic/widgets/common/user_profile.dart';
import 'package:ultrasound_clinic/widgets/common/user_profile_controls.dart';

class ClinicSettingsScreen extends StatefulWidget {
  const ClinicSettingsScreen({super.key});

  @override
  State<ClinicSettingsScreen> createState() => _ClinicSettingsScreenState();
}

class _ClinicSettingsScreenState extends State<ClinicSettingsScreen> {
  void logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LandingScreen(),
    ));
  }

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
            const UserProfile(),
            SizedBox(height: 90.h),
            const UserProfileControls(),
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                text: Strings.logout,
                onPressed: logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
