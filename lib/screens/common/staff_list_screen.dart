import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/constants/enums/role_enum.dart';

import 'package:ultrasound_clinic/containers/common/staff_list_container.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  void navigateToManageStaff() {}

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool isClinic =
        authProvider.currentUser!.role == UserRoleEnum.clinic.roleName;

    return Scaffold(
      appBar: const CustomAppBarText(
        title: Strings.staffList,
        showBackButton: true,
      ),
      body: const StaffListContainer(),
      floatingActionButton: isClinic
          ? FloatingActionButton(
              onPressed: navigateToManageStaff,
              backgroundColor: ThemeColors.primary,
              child: Icon(Icons.add, size: 30.ics),
            )
          : null,
    );
  }
}
