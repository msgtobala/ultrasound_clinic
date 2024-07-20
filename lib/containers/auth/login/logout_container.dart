import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
// import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/screens/auth/landing_screen.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/custom_outlined_button.dart';

class LogoutContainer extends StatelessWidget {
  const LogoutContainer({super.key});

  void logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.signOut();
    if (response) {
      ClinicRoutes.resetNavigatorKey();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      showSnackbar(context, Strings.errorLoggingOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      text: Strings.logout,
      onPressed: () => logout(context),
      buttonTextStyle: Theme.of(context).textTheme.errorBodyMedium,
      borderColor: ThemeColors.errorColor,
    );
  }
}
