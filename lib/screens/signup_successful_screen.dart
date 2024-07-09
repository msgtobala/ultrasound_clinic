import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';

class SignupSuccessFulScreen extends StatelessWidget {
  const SignupSuccessFulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 320,
                  child: Stack(
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
                Image.asset(Images.successBadge),
                const SizedBox(height: 20),
                Text(
                  Strings.signupSuccessful,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  Strings.redirectingText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
