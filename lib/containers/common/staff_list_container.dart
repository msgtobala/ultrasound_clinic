import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/constants/enums/role_enum.dart';

import 'package:ultrasound_clinic/core/services/staff/staff_service.dart';
import 'package:ultrasound_clinic/models/common/medical_persons_model.dart';
import 'package:ultrasound_clinic/models/common/staff_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/medical_person_list_item.dart';

class StaffListContainer extends StatefulWidget {
  const StaffListContainer({super.key});

  @override
  State<StaffListContainer> createState() => _StaffListContainerState();
}

class _StaffListContainerState extends State<StaffListContainer> {
  bool _isLoading = true;
  bool _isEdit = false;
  final StaffService _staffService = StaffService();
  List<StaffModel>? staffs;

  @override
  void initState() {
    super.initState();
    _fetchStaffs();
  }

  Future<void> _fetchStaffs() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    _isEdit = authProvider.currentUser!.role == UserRoleEnum.clinic.roleName;
    staffs = await _staffService.getStaffs(clinicId);
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToEditScreen(String uid) {
    final currentStaff = staffs?.firstWhere((staff) => staff.uid == uid);
    // Navigate to edit screen with currentDoctor
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (staffs == null || staffs!.isEmpty) {
      return const Center(child: Text(Strings.noStaffsFound));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.hs, vertical: 10.vs),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: staffs!.length,
              itemBuilder: (context, index) {
                return MedicalPersonListItem(
                  isEdit: _isEdit,
                  person: MedicalPersonsModel(
                    uid: staffs![index].uid,
                    personName: staffs![index].staffName,
                    imageUrl: staffs![index].imageUrl,
                    designation: staffs![index].designation,
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