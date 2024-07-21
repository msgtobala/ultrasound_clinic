import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';

import 'package:ultrasound_clinic/routes/patient_routes.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/clinic_code/clinic_code_form.dart';

class ClinicSelectionContainer extends StatefulWidget {
  const ClinicSelectionContainer({super.key});

  @override
  State<ClinicSelectionContainer> createState() =>
      _ClinicSelectionContainerState();
}

class _ClinicSelectionContainerState extends State<ClinicSelectionContainer> {
  bool _isLoading = true;

  void navigateToHomeNavigation() {
    Navigator.of(context).pushNamed(PatientRoutes.menu);
  }

  void onClinicSelection(String clinicCode) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });
    final response = await authProvider.checkExistingClinicCode(clinicCode);
    setState(() {
      _isLoading = false;
    });
    if (response) {
      navigateToHomeNavigation();
    } else {
      showSnackbar(context, Strings.clinicCodeFetchFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClinicCodeForm(
      isLoading: _isLoading,
      onClinicSelection: onClinicSelection,
    );
  }
}
