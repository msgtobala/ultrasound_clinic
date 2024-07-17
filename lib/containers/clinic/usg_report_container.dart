import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ultrasound_clinic/core/services/usg/usg_service.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/widgets/usg_report/usg_report.dart';

class USGReportContainer extends StatefulWidget {
  const USGReportContainer({super.key});

  @override
  State<USGReportContainer> createState() => _USGReportContainerState();
}

class _USGReportContainerState extends State<USGReportContainer> {
  final USGService usgService = USGService();
  bool _isLoading = false;
  bool _isUploading = false;
  List<USGModel> _usgs = [];

  Future<void> fetchUSG(String clinicId) async {
    setState(() {
      _isLoading = true;
    });

    final usgsList = await usgService.getUSGs(clinicId);
    if (usgsList.isNotEmpty) {
      setState(() {
        _isLoading = false;
        _usgs = usgsList;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void viewPrescription() {
    print('view prescription');
  }

  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    super.initState();

    if (clinicId.isNotEmpty) {
      fetchUSG(clinicId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return USGReport(
      isLoading: _isLoading,
      isUploading: _isUploading,
      usgs: _usgs,
      uploadReport: () {},
      viewPrescription: viewPrescription,
    );
  }
}
