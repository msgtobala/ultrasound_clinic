import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/constants/enums/role_enum.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/screens/auth/landing_screen.dart';
import 'package:ultrasound_clinic/screens/auth/login_screen.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/screens/clinic/clinic_app.dart';
import 'package:ultrasound_clinic/screens/patient/patient_app.dart';
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => authProvider.currentUser!.role ==
                        UserRoleEnum.clinic.roleName
                    ? const ClinicApp()
                    : const PatientApp(),
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
