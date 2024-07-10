import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/landing_custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsiveness.screenWidth;
    final screenHeight = Responsiveness.screenHeight;

    print(screenWidth);
    print(screenHeight);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                        ),
                        child: Image.asset(
                          Images.logo,
                        ),
                      ),
                      SizedBox(
                        width: 297,
                        height: 54,
                        child: Text(
                          Strings.landingQuote,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 68.7,
                          left: 10,
                          right: 10,
                          bottom: 18.73,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LandingCustomButton(
                              text: Strings.signIn,
                              onPressed: () {},
                            ),
                            LandingCustomButton(
                              text: Strings.register,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: screenWidth,
                    child: Image.asset(
                      Images.landingAvatar,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
