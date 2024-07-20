import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/clinic/edit_staff_container.dart';
import 'package:ultrasound_clinic/models/common/staff_model.dart';

class EditStaffScreen extends StatelessWidget {
  const EditStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StaffModel currentStaff =
        ModalRoute.of(context)!.settings.arguments as StaffModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: EditStaffContainer(
          currentStaff: currentStaff,
        ),
      ),
    );
  }
}
