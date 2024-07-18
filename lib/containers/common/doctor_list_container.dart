import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/doctor_model.dart';
import 'package:ultrasound_clinic/models/common/medical_persons_model.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/medical_person_list_item.dart';

class DoctorListContainer extends StatefulWidget {
  const DoctorListContainer({super.key});

  @override
  State<DoctorListContainer> createState() => _DoctorListContainerState();
}

class _DoctorListContainerState extends State<DoctorListContainer> {
  bool _isLoading = true;
  final List<DoctorModel> doctors = [
    DoctorModel(
      uid: "1",
      doctorName: 'Dr. Lina Thomas',
      degree: 'MD - Ultrasound',
      description: "",
      phoneNumber: "",
      imageUrl: 'assets/images/layout_background.png',
    ),
    DoctorModel(
      uid: "2",
      doctorName: 'Wanda Maximoff',
      degree: 'MD - Ultrasound',
      description: "",
      phoneNumber: "",
      imageUrl: 'assets/images/layout_background.png',
    ),
    DoctorModel(
      uid: "3",
      doctorName: 'Diana Prince',
      degree: 'MD - Ultrasound',
      description: "",
      phoneNumber: "",
      imageUrl: 'assets/images/layout_background.png',
    ),
    DoctorModel(
      uid: "4",
      doctorName: 'Karen Starr',
      degree: 'MD - Ultrasound',
      description: "",
      phoneNumber: "",
      imageUrl: 'assets/images/layout_background.png',
    ),
    DoctorModel(
      uid: "5",
      doctorName: 'Natasha Romanoff',
      degree: 'MD - Ultrasound',
      description: "",
      phoneNumber: "",
      imageUrl: 'assets/images/layout_background.png',
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Fetch doctors
  }

  void navigateToEditScreen(String uid) {
    final currentDoctor = doctors.firstWhere((doctor) => doctor.uid == uid);
    // Navigate to edit screen
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (doctors.isEmpty) {
      return const Center(child: Text('No doctors found'));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.hs, vertical: 10.vs),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return MedicalPersonListItem(
                  person: MedicalPersonsModel(
                    uid: doctors[index].uid,
                    personName: doctors[index].doctorName,
                    degree: doctors[index].degree,
                    imageUrl: doctors[index].imageUrl,
                  ),
                  navigateToEditScreen: navigateToEditScreen,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
