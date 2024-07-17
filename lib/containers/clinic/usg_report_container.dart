import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/firebase/firebase_storage_service.dart';
import 'package:ultrasound_clinic/core/services/usg/usg_service.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/utils/date_time/date_time.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/generic_media_dialog.dart';
import 'package:ultrasound_clinic/widgets/usg_report/usg_report.dart';

class USGReportContainer extends StatefulWidget {
  const USGReportContainer({super.key});

  @override
  State<USGReportContainer> createState() => _USGReportContainerState();
}

class _USGReportContainerState extends State<USGReportContainer> {
  final USGService usgService = USGService();
  final FirebaseStorageService storageService = FirebaseStorageService();
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

  void viewPrescription(String prescription) {
    Navigator.of(context).pushNamed(
      ClinicRoutes.viewAssets,
      arguments: prescription,
    );
  }

  void onSaveMedia(
    File file,
    String usgId,
    String userUsgId,
    String userId,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;

    setState(() {
      _isUploading = true;
    });

    final fileName = generateFileName('report_$usgId');
    final reportURL = await storageService.uploadFile(
      file,
      'clinics/$clinicId/reports/',
      fileName,
    );
    final response = await usgService.updateReportUrl(
      clinicId,
      usgId,
      userId,
      userUsgId,
      reportURL,
    );
    if (response) {
      final updatedUSG = _usgs.firstWhere((usg) => usg.uid == usgId);
      updatedUSG.report = reportURL;
      setState(() {
        _isUploading = false;
        _usgs = _usgs;
      });
      showSnackbar(context, Strings.reportUploadedSuccessfully);
    } else {
      setState(() {
        _isUploading = false;
      });
      showSnackbar(context, Strings.reportUploadFailed);
    }
  }

  void reportAction(
      String report, String usgId, String userUsgId, String userId) {
    if (report.isNotEmpty) {
      Navigator.of(context).pushNamed(
        ClinicRoutes.viewAssets,
        arguments: report,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return GenericMediaDialog(
            mediaHeading: '${Strings.upload} ${Strings.report}',
            onSaveMedia: (File file) =>
                onSaveMedia(file, usgId, userUsgId, userId),
          );
        },
      );
    }
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
      reportAction: reportAction,
      viewPrescription: viewPrescription,
    );
  }
}
