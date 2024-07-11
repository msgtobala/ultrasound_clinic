import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/screens/home.dart';
import 'package:ultrasound_clinic/screens/landing_screen.dart';
import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/screens/signup_successful_screen.dart';
import 'package:ultrasound_clinic/utils/shared_preference/shared_preference.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();

    // Listen for changes in the AuthProvider
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      authProvider.addListener(() {
        if (!authProvider.isLoading) {
          if (authProvider.user == null && context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LandingScreen(),
              ),
            );
            return;
          }

          if (authProvider.user != null &&
              authProvider.user!.emailVerified &&
              authProvider.loggedInStatus == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
            return;
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SVGLoader(
              image: Images.logo,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
