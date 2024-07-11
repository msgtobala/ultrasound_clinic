import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/clinic_selection/clinic_selection_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';
import 'package:ultrasound_clinic/resources/strings.dart';

class ClinicSelectionScreen extends StatelessWidget {
  const ClinicSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      pageTitle: Strings.enterClinicCode,
      pageDescription: '',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClinicSelectionContainer(),
        ],
      ),
    );
  }
}
