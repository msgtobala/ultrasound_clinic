import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/constants/enums/role_enum.dart';

import 'package:ultrasound_clinic/core/services/doctors/doctors_service.dart';
import 'package:ultrasound_clinic/models/common/doctor_model.dart';
import 'package:ultrasound_clinic/models/common/medical_persons_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/medical_person_list_item.dart';

class DoctorListContainer extends StatefulWidget {
  const DoctorListContainer({super.key});

  @override
  State<DoctorListContainer> createState() => _DoctorListContainerState();
}

class _DoctorListContainerState extends State<DoctorListContainer> {
  bool _isLoading = true;
  bool _isEdit = false;
  final DoctorService _doctorService = DoctorService();
  List<DoctorModel>? doctors;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _isEdit = authProvider.currentUser!.role == UserRoleEnum.clinic.roleName;
    final clinicId = authProvider.currentUser!.clinics.first;
    doctors = await _doctorService.getDoctors(clinicId);
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToEditScreen(String uid) {
    final currentDoctor = doctors?.firstWhere((doctor) => doctor.uid == uid);
    Navigator.of(context)
        .pushNamed(ClinicRoutes.addAndEditDoctor, arguments: currentDoctor);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (doctors == null || doctors!.isEmpty) {
      return const Center(child: Text(Strings.noDoctorsFound));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.hs, vertical: 10.vs),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: doctors!.length,
              itemBuilder: (context, index) {
                return MedicalPersonListItem(
                  isEdit: _isEdit,
                  person: MedicalPersonsModel(
                    uid: doctors![index].uid,
                    personName: doctors![index].doctorName,
                    degree: doctors![index].degree,
                    imageUrl: doctors![index].imageUrl,
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
