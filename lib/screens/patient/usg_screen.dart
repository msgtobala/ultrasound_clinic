import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/usg/usg_container.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class UsgScreen extends StatelessWidget {
  const UsgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                Strings.usgForm,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 42.h,
              ),
              const UsgContainer()
            ],
          ),
        ),
      ),
    );
  }
}
