import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/containers/profile/profile_container.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 320,
                child: Stack(
                  children: [
                    // Image.asset('placeholder'),
                    Column(
                      children: [
                        Text(Strings.signIn),
                        Text(Strings.enterSignInDetails)
                      ],
                    )
                  ],
                ),
              ),
              const ProfileContainer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.white,
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: ThemeColors.errorColor)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Text(
                      Strings.logout,
                      style: Theme.of(context).textTheme.bodyMediumDanger,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
