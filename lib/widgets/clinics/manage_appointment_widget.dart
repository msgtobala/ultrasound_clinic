import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/widgets/clinics/appointment_list.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class ManageAppointmentWidget extends StatelessWidget {
  const ManageAppointmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormInput(
          text: Strings.search,
        ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: const [
                    Tab(text: Strings.today),
                    Tab(text: Strings.upcoming),
                  ],
                  labelColor: ThemeColors.black,
                  unselectedLabelColor: ThemeColors.gray200,
                  indicatorColor: ThemeColors.primary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      AppointmentList(tab: Strings.today),
                      AppointmentList(tab: Strings.upcoming),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
