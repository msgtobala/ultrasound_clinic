import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/patient/usg_form_container.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class USGFormScreen extends StatelessWidget {
  const USGFormScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: const USGFormContainer(),
      ),
    );
  }
}
