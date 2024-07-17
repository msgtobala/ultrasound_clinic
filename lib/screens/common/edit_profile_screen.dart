import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/containers/common/edit_profile_container.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.d),
            child: const EditProfileContainer(),
          ),
        ),
      ),
    );
  }
}
