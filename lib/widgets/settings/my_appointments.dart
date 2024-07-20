import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/utils/date_time/date_time.dart';
import 'package:ultrasound_clinic/widgets/appointments/user_appointment_list.dart';

class MyAppointments extends StatelessWidget {
  final bool isLoading;
  final List<UserAppointmentModel> appointments;
  final void Function() onTap;
  final DateTime? date;

  const MyAppointments({
    super.key,
    required this.isLoading,
    required this.appointments,
    required this.onTap,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.d),
              color: ThemeColors.gray200.withOpacity(0.5),
            ),
            margin: EdgeInsets.symmetric(vertical: 20.vs, horizontal: 20.hs),
            padding: EdgeInsets.all(20.s),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.calendar_today, color: ThemeColors.black),
                Text(
                  formatDate(date),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.hs),
              child: UserAppointmentList(
                isLoading: isLoading,
                userAppointments: appointments,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
