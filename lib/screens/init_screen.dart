import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/screens/home.dart';
import 'package:ultrasound_clinic/screens/landing_screen.dart';
import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';
import 'package:ultrasound_clinic/screens/doctor_list.dart';
import 'package:ultrasound_clinic/screens/setting_screen.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.addListener(() {
        // No user data -> user == null -> Landing screen
        // User != null but but not email verified -> EmailVerification()
        // User != null and email verified but not logged -> LoginScreen()
        // User !== null and email verified and logged -> Load either clientApp() or PatientApp() based on role
        if (!authProvider.isLoading) {
          if (authProvider.user == null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LandingScreen(),
              ),
            );
            return;
          }
          if (authProvider.user != null && authProvider.user!.emailVerified) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
            return;
          } else {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const LoginScreen()),
            // );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ClinicManagementScreen()),
            );
            return;
          }
        }
      });

      // Start the initial check
      // authProvider._delayUserCheck();
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


// class InitScreen extends StatefulWidget {
//   const InitScreen({super.key});

//   @override
//   State<InitScreen> createState() => _InitScreenState();
// }

// class _InitScreenState extends State<InitScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, authProvider, child) {
//         if (authProvider.isLoading) {
//           return const Scaffold(
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: SVGLoader(
//                     image: Images.logo,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 CircularProgressIndicator(),
//               ],
//             ),
//           );
//         } else {
//           if (authProvider.user != null && authProvider.user!.emailVerified) {
//             log.i(authProvider.user!.uid);
//             return const Scaffold(
//               body: Center(
//                 child: Text('Home'),
//               ),
//             );
//           } else {
//             return const LoginScreen();
//           }
//         }
//       },
//     );
//   }
// }
