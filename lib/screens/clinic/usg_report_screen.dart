import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/clinic/usg_report_container.dart';
import 'package:ultrasound_clinic/widgets/common/custom_accordion.dart';

class USGReportScreen extends StatelessWidget {
  const USGReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const USGReportContainer();
    return const AccordionPage();
  }
}
