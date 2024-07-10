import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/clinic_code/clinic_code_container.dart';
import 'package:ultrasound_clinic/layout/base_layout.dart';

import 'package:ultrasound_clinic/resources/strings.dart';

class ClinicCodeScreen extends StatelessWidget {
  const ClinicCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      pageTitle: Strings.enterClinicCode,
      pageDescription: '',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClinicCodeContainer(),
        ],
      ),
    );
  }
}
