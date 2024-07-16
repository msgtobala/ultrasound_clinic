import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/containers/patient/today_appintments_container.dart';
import 'package:ultrasound_clinic/containers/patient/upcoming_appointments_container.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/form_input.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.vs, horizontal: 20.hs),
      child: Column(
        children: [
          const FormInput(
            text: Strings.search,
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: DefaultTabController(
              length: constants.appointmentTabs,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          Strings.today,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Tab(
                        child: Text(
                          Strings.upcoming,
                          style: Theme.of(context).textTheme.headlineSmallGray,
                        ),
                      ),
                    ],
                    labelColor: ThemeColors.black,
                    unselectedLabelColor: ThemeColors.gray200,
                    indicatorColor: ThemeColors.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3,
                  ),
                  SizedBox(height: 30.h),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        TodaysAppointmentsContainer(),
                        UpcomingAppointmentsContainer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
