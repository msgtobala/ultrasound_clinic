import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/common/doctor_list_container.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';

class DoctorsListScreen extends StatelessWidget {
  const DoctorsListScreen({super.key});

  void navigateToManageDoctor() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarText(
        title: Strings.doctorList,
        showBackButton: true,
      ),
      body: const DoctorListContainer(),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToManageDoctor,
        backgroundColor: ThemeColors.primary,
        child: Icon(Icons.add, size: 30.ics),
      ),
    );
  }
}
