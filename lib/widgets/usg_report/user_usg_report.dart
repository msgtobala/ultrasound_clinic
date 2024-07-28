import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/utils/snackbar/show_snackbar.dart';
import 'package:ultrasound_clinic/widgets/common/custom_accordion/custom_accordion.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_avatar.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/custom_outlined_button.dart';
import 'package:ultrasound_clinic/widgets/common/custom_shimmer/custom_card_shimmer.dart';

class UserUsgReport extends StatefulWidget {
  const UserUsgReport({
    super.key,
    required this.isLoading,
    required this.usgs,
    required this.viewPrescription,
    required this.viewReport,
    required this.viewAcknowledge,
  });

  final bool isLoading;
  final List<UserUSGModel> usgs;
  final Function(String prescription) viewPrescription;
  final Function(String report) viewReport;
  final Function(String receipt) viewAcknowledge;

  @override
  State<UserUsgReport> createState() => _UserUsgReportState();
}

class _UserUsgReportState extends State<UserUsgReport> {
  int _selectedIndex = -1;
  int _selectedShareIndex = -1;

  void toggleExpanded(int index) {
    setState(() {
      if (index == _selectedIndex) {
        _selectedIndex = -1;
      } else {
        _selectedIndex = index;
      }
    });
  }

  void onShare(BuildContext context, String imageUrl, int index) async {
    if (imageUrl.isEmpty) {
      showSnackbar(context, Strings.noImageToShare);
      return;
    }

    try {
      // Get the download URL from Firebase Storage
      setState(() {
        _selectedShareIndex = index;
      });
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);

      // Create a temporary file
      final tempDir = Directory.systemTemp;
      final fileName =
          'shared_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';

      // Download the file
      final file = File(filePath);
      await ref.writeToFile(file);
      setState(() {
        _selectedShareIndex = -1;
      });
      if (await file.exists()) {
        // Share the file
        final result = await Share.shareXFiles([XFile(filePath)]);

        if (result.status == ShareResultStatus.success && context.mounted) {
          showSnackbar(context, Strings.imageSharedSuccessfully);
        }

        // Delete the temporary file
        await file.delete();
      } else {
        showSnackbar(context, Strings.failedToDownloadImage);
      }
    } catch (e) {
      // Dismiss loading indicator if it's still showing
      if (context.mounted) {
        Navigator.of(context).pop();
        showSnackbar(context, "Error sharing image");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const CustomCardShimmer();
    }

    if (widget.usgs.isEmpty) {
      return Center(
        child: Text(
          Strings.noUSGReports,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.vs, horizontal: 16.hs),
      shrinkWrap: widget.usgs.length > 10 ? true : false,
      itemCount: widget.usgs.length,
      itemBuilder: (BuildContext context, int index) {
        final usg = widget.usgs[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10.vs),
          child: CustomAccordion(
            toggleExpanded: (ind) => toggleExpanded(index),
            children: [
              ExpansionPanel(
                backgroundColor: Theme.of(context).primaryColor,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    horizontalTitleGap: 10,
                    contentPadding: EdgeInsets.all(10.d),
                    title: Text(
                      usg.patientName,
                      style: Theme.of(context).textTheme.headlineSmallWhite,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usg.mobileNumber,
                          style: Theme.of(context).textTheme.bodyMediumWhite,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 18,
                              color: ThemeColors.white,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              usg.receiptUrl.isEmpty
                                  ? Strings.notAcknowledged
                                  : (usg.report.isEmpty
                                      ? Strings.reportNotUploaded
                                      : Strings.reportUploaded),
                              style:
                                  Theme.of(context).textTheme.displaySmallWhite,
                            ),
                          ],
                        ),
                      ],
                    ),
                    leading: CustomAvatar(
                      imageUrl: usg.prescription,
                      isNetwork: true,
                      radius: 40,
                    ),
                    trailing: Container(
                      color: Theme.of(context).primaryColor,
                      width: 50.w,
                      height: 50.h,
                      child: InkWell(
                        onTap: () => toggleExpanded(index),
                        child: isExpanded
                            ? Icon(
                                Icons.expand_less,
                                color: Colors.white,
                                size: 30.ics,
                              )
                            : Icon(
                                Icons.expand_more,
                                color: Colors.white,
                                size: 30.ics,
                              ),
                      ),
                    ),
                  );
                },
                body: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.hs,
                    vertical: 8.vs,
                  ),
                  decoration: BoxDecoration(color: ThemeColors.white),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(Strings.phoneNumber),
                        subtitle: Text(usg.mobileNumber),
                      ),
                      ListTile(
                        title: const Text(Strings.city),
                        subtitle: Text(usg.city),
                      ),
                      ListTile(
                        title: const Text(Strings.pinCode),
                        subtitle: Text(usg.pinCode),
                      ),
                      ListTile(
                        title: const Text(Strings.state),
                        subtitle: Text(usg.state),
                      ),
                      SizedBox(height: 12.vs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: CustomElevatedButton(
                                  text: Strings.viewPrescription,
                                  buttonSize: ButtonSize.extraSmall,
                                  buttonTextStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMediumWhite,
                                  onPressed: () =>
                                      widget.viewPrescription(usg.prescription),
                                ),
                              ),
                              _selectedShareIndex == 0
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () =>
                                          onShare(context, usg.prescription, 0),
                                      child: Icon(
                                        Icons.share,
                                        color: usg.prescription.isEmpty
                                            ? ThemeColors.gray200
                                            : ThemeColors.black,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 8.vs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: CustomElevatedButton(
                                  text: usg.receiptUrl.isEmpty
                                      ? Strings.acknowledge
                                      : Strings.acknowledged,
                                  buttonTextStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMediumWhite,
                                  onPressed: () {
                                    widget.viewAcknowledge(usg.receiptUrl);
                                  },
                                ),
                              ),
                              _selectedShareIndex == 1
                                  ? SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () =>
                                          onShare(context, usg.receiptUrl, 1),
                                      child: Icon(
                                        Icons.share,
                                        color: usg.receiptUrl.isEmpty
                                            ? ThemeColors.gray200
                                            : ThemeColors.black,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 8.vs),
                          if (usg.receiptUrl.isNotEmpty)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: CustomOutlinedButton(
                                        text: usg.report.isNotEmpty
                                            ? Strings.viewReport
                                            : Strings.uploadReport,
                                        borderColor: ThemeColors.primary,
                                        buttonSize: ButtonSize.extraSmall,
                                        buttonTextStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMediumPrimary,
                                        onPressed: () =>
                                            widget.viewReport(usg.report),
                                      ),
                                    ),
                                    _selectedShareIndex == 2
                                        ? SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () =>
                                                onShare(context, usg.report, 2),
                                            child: Icon(
                                              Icons.share,
                                              color: usg.report.isEmpty
                                                  ? ThemeColors.gray200
                                                  : ThemeColors.black,
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 10.vs),
                              ],
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                isExpanded: index == _selectedIndex,
                canTapOnHeader: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
