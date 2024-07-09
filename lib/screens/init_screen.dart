import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/screens/login_screen.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          if (authProvider.user != null && authProvider.user!.emailVerified) {
            return const Scaffold(
              body: Center(
                child: Text('Home'),
              ),
            );
          } else {
            // return const LoginScreen();
            return const ClinicManagementScreen();
          }
        }
      },
    );
  }
}
