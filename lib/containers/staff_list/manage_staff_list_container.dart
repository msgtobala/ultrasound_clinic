import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/common/manage_doctor_staff_list.dart';

class ManageStaffListContainer extends StatelessWidget {
  const ManageStaffListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ManageDoctorStaffList(
      identifier: "staff",
    );
  }
}
