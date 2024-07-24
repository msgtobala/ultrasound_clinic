import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_accordion/custom_accordion.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_avatar.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/custom_outlined_button.dart';
import 'package:ultrasound_clinic/widgets/common/custom_shimmer/custom_card_shimmer.dart';

class USGReport extends StatefulWidget {
  const USGReport({
    super.key,
    required this.isLoading,
    required this.isUploading,
    required this.currentUsgId,
    required this.usgs,
    required this.viewPrescription,
    required this.reportAction,
  });

  final bool isLoading;
  final bool isUploading;
  final List<USGModel> usgs;
  final String currentUsgId;
  final Function(String prescription) viewPrescription;
  final Function(
    String report,
    String uid,
    String userUsgId,
    String userId,
  ) reportAction;

  @override
  State<USGReport> createState() => _USGReportState();
}

class _USGReportState extends State<USGReport> {
  int _selectedIndex = -1;

  void toggleExpanded(int index) {
    setState(() {
      if (index == _selectedIndex) {
        _selectedIndex = -1;
      } else {
        _selectedIndex = index;
      }
    });
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
                              usg.report != ''
                                  ? Strings.reportUploaded
                                  : Strings.reportNotUploaded,
                              style: Theme.of(context).textTheme.bodySmall,
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
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomElevatedButton(
                            text: Strings.viewPrescription,
                            buttonSize: ButtonSize.extraSmall,
                            buttonTextStyle:
                                Theme.of(context).textTheme.bodyMediumWhite,
                            onPressed: () =>
                                widget.viewPrescription(usg.prescription),
                          ),
                          CustomOutlinedButton(
                            text: usg.report.isNotEmpty
                                ? Strings.viewReport
                                : Strings.uploadReport,
                            isLoading: widget.isUploading &&
                                widget.currentUsgId == usg.uid,
                            borderColor: ThemeColors.primary,
                            buttonSize: ButtonSize.extraSmall,
                            buttonTextStyle:
                                Theme.of(context).textTheme.bodyMediumPrimary,
                            onPressed: () => widget.reportAction(
                              usg.report,
                              usg.uid,
                              usg.usgRefId,
                              usg.userId,
                            ),
                          ),
                        ],
                      ),
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
