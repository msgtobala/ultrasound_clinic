import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ultrasound_clinic/resources/strings.dart';

class SignupSucessfullScreen extends StatelessWidget {
  const SignupSucessfullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                //Todo : badge
                SizedBox(
                  height: 20.px,
                ),
                Text(
                  Strings.signupSucessful,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 10.px,
                ),
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
