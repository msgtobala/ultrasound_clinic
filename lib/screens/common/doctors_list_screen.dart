import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/constants/enums/role_enum.dart';
import 'package:ultrasound_clinic/containers/common/doctor_list_container.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';

class DoctorsListScreen extends StatelessWidget {
  const DoctorsListScreen({super.key});

  void navigateToAddDoctor(BuildContext context) {
    Navigator.of(context).pushNamed(ClinicRoutes.addDoctor);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool isClinic =
        authProvider.currentUser!.role == UserRoleEnum.clinic.roleName;

    return Scaffold(
      appBar: const CustomAppBarText(
        title: Strings.doctorList,
        showBackButton: true,
      ),
      body: DoctorListContainer(isClinic: isClinic),
      floatingActionButton: isClinic
          ? FloatingActionButton(
              onPressed: () => navigateToAddDoctor(context),
              backgroundColor: ThemeColors.primary,
              child: Icon(Icons.add, size: 30.ics),
            )
          : null,
    );
  }
}
