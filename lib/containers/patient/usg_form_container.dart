import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/usg/usg_service.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_info_dialog.dart';
import 'package:ultrasound_clinic/widgets/usg_form/usg_form.dart';

class USGFormContainer extends StatefulWidget {
  const USGFormContainer({super.key});

  @override
  State<USGFormContainer> createState() => _USGFormContainerState();
}

class _USGFormContainerState extends State<USGFormContainer> {
  final USGService usgService = USGService();
  bool _isLoading = false;

  void onCopy(String appointmentId) {
    Clipboard.setData(ClipboardData(text: appointmentId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(Strings.copiedToCLipboard)),
    );
  }

  void onClose(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void showConfirmationPop(String usgReference) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomInfoDialog(
          title: Strings.usgSubmitted,
          content: Strings.prescriptionsUploadedSuccessfully,
          displayData: usgReference,
          onClose: onClose,
          onCopy: onCopy,
        );
      },
    );
  }

  Future<void> addUSG(Map<String, dynamic> usg) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // Since this is related to the patient, we will use selected clinic
    final clinicId = authProvider.selectedClinicCode;
    final userId = authProvider.currentUser!.uid;

    setState(() {
      _isLoading = true;
    });

    final usgReference = await usgService.createUSG(clinicId, userId, usg);

    setState(() {
      _isLoading = false;
    });

    if (usgReference != null) {
      showConfirmationPop(usgReference);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Strings.failedToAddUSG),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return USGForm(isLoading: _isLoading, addUSG: addUSG);
  }
}
