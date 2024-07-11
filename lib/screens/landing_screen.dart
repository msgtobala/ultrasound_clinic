import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  void _navigateToSignup(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsiveness.screenWidth;
    final screenHeight = Responsiveness.screenHeight;

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
                        padding: EdgeInsets.only(top: 60.h),
                        child: const SVGLoader(image: Images.logo),
                      ),
                      SizedBox(
                        width: 297.w,
                        height: 54.h,
                        child: Text(
                          Strings.landingQuote,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 69,
                          left: 10,
                          right: 10,
                          bottom: 18,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomElevatedButton(
                              text: Strings.signIn,
                              onPressed: () => _navigateToLogin(context),
                            ),
                            CustomElevatedButton(
                              text: Strings.register,
                              onPressed: () => _navigateToSignup(context),
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
