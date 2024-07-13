import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/staff_list/manage_staff_list_container.dart';

class ManageStaffListScreen extends StatelessWidget {
  const ManageStaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: ManageStaffListContainer(),
        ),
      ),
    );
  }
}
