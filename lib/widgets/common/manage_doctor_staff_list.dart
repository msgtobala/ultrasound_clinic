import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/models/clinics/doctor_model.dart';
import 'package:ultrasound_clinic/models/clinics/staff_model.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';
import 'package:ultrasound_clinic/widgets/common/manage_doctor_staff_list_item.dart';

class ManageDoctorStaffList extends StatelessWidget {
  const ManageDoctorStaffList({super.key, required this.identifier});

  final String identifier;

  @override
  Widget build(BuildContext context) {
    final List<DoctorModel> dummyDoctors = [
      const DoctorModel(
          name: "Dr.Girl", position: "MD", clinicName: "Ultrasonic"),
      const DoctorModel(
          name: "Dr.Boy", position: "MD", clinicName: "Ultrasonic")
    ];
    final List<StaffModel> dummyStaffs = [
      const StaffModel(
        name: "Staff 1",
        position: "Nurse",
      ),
      const StaffModel(
        name: "Staff 2",
        position: "Sweeper",
      )
    ];
    if (identifier == "doctor") {
      return Column(
        children: [
          const FormInput(
            text: Strings.search,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dummyDoctors.length,
              itemBuilder: (ctx, index) {
                final doctor = dummyDoctors[index];
                return ManageDoctorStaffListItem(
                  doctorName: doctor.name,
                  position: doctor.position,
                  clinicName: doctor.clinicName,
                );
              },
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        const FormInput(
          text: Strings.search,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dummyStaffs.length,
            itemBuilder: (ctx, index) {
              final doctor = dummyStaffs[index];
              return ManageDoctorStaffListItem(
                doctorName: doctor.name,
                position: doctor.position,
              );
            },
          ),
        ),
      ],
    );
  }
}
