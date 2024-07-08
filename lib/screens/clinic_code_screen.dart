import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ultrasound_clinic/containers/clinic_code/clinic_code_container.dart';

import 'package:ultrasound_clinic/resources/strings.dart';

class ClinicCodeScreen extends StatelessWidget {
  const ClinicCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 320.px,
                child: const Stack(
                  children: [
                    // Image.asset('placeholder'),
                    Column(
                      children: [
                        Text(Strings.signIn),
                        Text("Enter your user name and password to login!")
                      ],
                    )
                  ],
                ),
              ),
              const ClinicCodeContainer()
            ],
          ),
        ),
      ),
    );
  }
}
