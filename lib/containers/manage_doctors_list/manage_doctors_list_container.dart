import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/common/manage_doctor_staff_list.dart';

class DoctorsListContainer extends StatelessWidget {
  const DoctorsListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ManageDoctorStaffList(
      identifier: "doctor",
    );
  }
}
