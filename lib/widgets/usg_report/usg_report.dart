import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/enums/button_size.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/widgets/common/custom_accordion/custom_accordion.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/custom_outlined_button.dart';

class USGReport extends StatefulWidget {
  const USGReport({
    super.key,
    required this.isLoading,
    required this.isUploading,
    required this.usgs,
    required this.uploadReport,
    required this.viewPrescription,
  });

  final bool isLoading;
  final bool isUploading;
  final List<USGModel> usgs;
  final Function(String prescription) viewPrescription;
  final Function() uploadReport;

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
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.vs, horizontal: 16.hs),
        child: CustomAccordion(
          toggleExpanded: toggleExpanded,
          children:
              widget.usgs.asMap().entries.map((MapEntry<int, USGModel> usg) {
            return ExpansionPanel(
              backgroundColor: Theme.of(context).primaryColor,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.d),
                  title: Text(
                    usg.value.patientName,
                    style: Theme.of(context).textTheme.headlineSmallWhite,
                  ),
                  subtitle: Text(
                    usg.value.mobileNumber,
                    style: Theme.of(context).textTheme.bodyMediumWhite,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40.d,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  trailing: Container(
                    color: Theme.of(context).primaryColor,
                    width: 50.w,
                    height: 50.h,
                    child: InkWell(
                      onTap: () => toggleExpanded(usg.key),
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
                      subtitle: Text(usg.value.mobileNumber),
                    ),
                    ListTile(
                      title: const Text(Strings.city),
                      subtitle: Text(usg.value.city),
                    ),
                    ListTile(
                      title: const Text(Strings.pinCode),
                      subtitle: Text(usg.value.pinCode),
                    ),
                    ListTile(
                      title: const Text(Strings.state),
                      subtitle: Text(usg.value.state),
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
                              widget.viewPrescription(usg.value.prescription),
                        ),
                        CustomOutlinedButton(
                          text: usg.value.report.isNotEmpty
                              ? Strings.viewReport
                              : Strings.uploadReport,
                          borderColor: ThemeColors.primary,
                          buttonSize: ButtonSize.extraSmall,
                          buttonTextStyle:
                              Theme.of(context).textTheme.bodyMediumPrimary,
                          onPressed: widget.uploadReport,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              isExpanded: usg.key == _selectedIndex,
              canTapOnHeader: true,
            );
          }).toList(),
        ),
      ),
    );
  }
}
