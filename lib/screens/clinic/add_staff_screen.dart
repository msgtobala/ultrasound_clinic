import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/clinic/add_staff_container.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';

class AddStaffScreen extends StatelessWidget {
  const AddStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarText(
        title: Strings.addStaff,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.d),
            child: const AddStaffContainer(),
          ),
        ),
      ),
    );
  }
}
