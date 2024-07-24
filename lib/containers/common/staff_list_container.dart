import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/constants/enums/role_enum.dart';
import 'package:ultrasound_clinic/core/services/staff/staff_service.dart';
import 'package:ultrasound_clinic/models/common/medical_persons_model.dart';
import 'package:ultrasound_clinic/models/common/staff_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/custom_shimmer/custom_card_shimmer.dart';
import 'package:ultrasound_clinic/widgets/common/medical_person_list_item.dart';

class StaffListContainer extends StatefulWidget {
  final bool isClinic;

  const StaffListContainer({super.key, required this.isClinic});

  @override
  State<StaffListContainer> createState() => _StaffListContainerState();
}

class _StaffListContainerState extends State<StaffListContainer> {
  bool _isEdit = false;
  final StaffService _staffService = StaffService();
  late Stream<List<StaffModel>> _staffStream;

  @override
  void initState() {
    super.initState();
    _initializeStaffStream();
  }

  void _initializeStaffStream() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = widget.isClinic
        ? authProvider.currentUser!.clinics.first
        : authProvider.selectedClinicCode;
    _isEdit = authProvider.currentUser!.role == UserRoleEnum.clinic.roleName;
    _staffStream = _staffService.getStaffsStream(clinicId);
  }

  void navigateToEditScreen(String uid) {
    _staffStream.listen((staffs) {
      final currentStaff = staffs.firstWhere((staff) => staff.uid == uid);
      Navigator.of(context).pushNamed(
        ClinicRoutes.editStaff,
        arguments: currentStaff,
      );
    });
  }

  void onDelete(String staffId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;

    final response = await StaffService().deleteStaff(clinicId, staffId);
    if (response) {
      showSnackbar(context, Strings.doctorDeletedSuccessfully);
    } else {
      showSnackbar(context, Strings.doctorDeletionFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StaffModel>>(
      stream: _staffStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomCardShimmer();
        }
        if (snapshot.hasError) {
          return const Center(child: Text(Strings.errorLoadingStaff));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              Strings.noStaffsFound,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        }

        final staffs = snapshot.data!;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.hs, vertical: 10.vs),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: staffs.length,
                  itemBuilder: (context, index) {
                    return MedicalPersonListItem(
                      isEdit: _isEdit,
                      onDelete: onDelete,
                      person: MedicalPersonsModel(
                        uid: staffs[index].uid,
                        personName: staffs[index].staffName,
                        imageUrl: staffs[index].imageUrl,
                        designation: staffs[index].designation,
                      ),
                      navigateToEditScreen: (uid) {
                        final currentStaff =
                            staffs.firstWhere((staff) => staff.uid == uid);
                        Navigator.of(context).pushNamed(
                          ClinicRoutes.editStaff,
                          arguments: currentStaff,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
