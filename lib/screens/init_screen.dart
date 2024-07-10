import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/screens/home.dart';
import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.addListener(() {
        if (!authProvider.isLoading) {
          if (authProvider.user == null) {
            // Show landing screen
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
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
