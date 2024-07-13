import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/containers/manage_doctors_list/manage_doctors_list_container.dart';

class ManageDoctorsListScreen extends StatelessWidget {
  const ManageDoctorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: DoctorsListContainer(),
        ),
      ),
    );
  }
}
