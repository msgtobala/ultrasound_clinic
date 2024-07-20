import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/patient/my_appointments_container.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarText(
        title: Strings.myAppointments,
        showBackButton: true,
      ),
      body: MyAppointmentsContainer(),
    );
  }
}
