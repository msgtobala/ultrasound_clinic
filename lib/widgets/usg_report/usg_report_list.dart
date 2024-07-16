import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/usg_report/usg_report_list_card.dart';

class USGReportList extends StatelessWidget {
  const USGReportList({super.key});

  final List<Map<String, dynamic>> usgPatients = const [
    {
      "name": "Person 1",
      "phone": 9976795710,
      "address": "Marathahalli",
      "prescription": "path_to_prescription",
      "city": "banglore",
      "state": "karnataka",
      "pinCode": 868689,
    },
    {
      "name": "Person 2",
      "phone": 9976795711,
      "address": "Marathahalli",
      "prescription": "path_to_prescription",
      "city": "banglore",
      "state": "karnataka",
      "pinCode": 868689,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usgPatients.length,
      itemBuilder: (ctx, index) {
        final patient = usgPatients[index];
        return USGReportListCard(
          usgReportDetail: patient,
        );
      },
    );
  }
}
