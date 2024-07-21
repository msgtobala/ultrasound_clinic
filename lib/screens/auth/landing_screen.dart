import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/screens/auth/login_screen.dart';
import 'package:ultrasound_clinic/screens/auth/signup_screen.dart';
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
        MaterialPageRoute(builder: (ctx) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsiveness.screenWidth;
    final screenHeight = Responsiveness.screenHeight;

    Widget content = SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Column(
        children: [
          SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 120.h),
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
                    top: 40,
                    left: 35,
                    right: 35,
                    bottom: 22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomElevatedButton(
                          text: Strings.signIn,
                          onPressed: () => _navigateToLogin(context),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        flex: 1,
                        child: CustomElevatedButton(
                          text: Strings.register,
                          onPressed: () => _navigateToSignup(context),
                        ),
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
              child: const SVGLoader(
                image: Images.landingAvatar,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );

    if (kIsWeb) {
      content = Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: content,
        ),
      );
    }

    return Scaffold(
      body: content,
    );
  }
}