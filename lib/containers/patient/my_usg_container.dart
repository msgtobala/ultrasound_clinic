import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/usg/usg_service.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/patient_routes.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/usg_report/user_usg_report.dart';

class MyUsgContainer extends StatefulWidget {
  const MyUsgContainer({super.key});

  @override
  State<MyUsgContainer> createState() => _MyUsgContainerState();
}

class _MyUsgContainerState extends State<MyUsgContainer> {
  final USGService usgService = USGService();
  bool _isLoading = false;
  List<UserUSGModel> _usg = [];
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchUSG(true);
  }

  Future<void> fetchUSG([bool? initialLoad]) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser!.uid;

    if (userId.isEmpty) {
      return;
    }

    if (initialLoad == true) {
      setState(() {
        _isLoading = true;
      });
    }

    final usgsList = await usgService.getUserUSGs(userId);
    if (usgsList.isNotEmpty) {
      setState(() {
        _usg = usgsList;
      });
    }

    if (initialLoad == true) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void viewReport(String report) {
    if (report.isEmpty) {
      showSnackbar(context, Strings.noReportUploaded);
      return;
    }
    Navigator.of(context).pushNamed(
      PatientRoutes.viewAssets,
      arguments: {'imageURL': report, 'text': Strings.report},
    );
  }

  void viewPrescription(String prescription) {
    Navigator.of(context).pushNamed(
      PatientRoutes.viewAssets,
      arguments: {'imageURL': prescription, 'text': Strings.prescription},
    );
  }

  void viewAcknowledge(String receipt) {
    if (receipt.isEmpty) {
      showSnackbar(context, Strings.noReceiptUploaded);
      return;
    }
    Navigator.of(context).pushNamed(
      PatientRoutes.viewAssets,
      arguments: {'imageURL': receipt, 'text': Strings.receipt},
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetchUSG(true),
      child: UserUsgReport(
        isLoading: _isLoading,
        usgs: _usg,
        viewReport: viewReport,
        viewPrescription: viewPrescription,
        viewAcknowledge: viewAcknowledge,
      ),
    );
  }
}
