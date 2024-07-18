import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/common/edit_profile_container.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: EditProfileContainer());
  }
}
