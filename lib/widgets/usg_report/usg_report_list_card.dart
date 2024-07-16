import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/screens/clinic/usg_report_list_screen.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class USGReportListCard extends StatelessWidget {
  const USGReportListCard({super.key, required this.usgReportDetail});

  final Map<String, dynamic> usgReportDetail;

  @override
  Widget build(BuildContext context) {
    final String name = usgReportDetail["name"];
    final num phone = usgReportDetail["phone"];
    // final String address = usgReportDetail["address"];
    final String city = usgReportDetail["city"];
    final String state = usgReportDetail["state"];
    final num pinCode = usgReportDetail["pinCode"];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.vs, horizontal: 20.hs),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => UsgReportListScreen(
                  name: name,
                  phone: phone,
                  city: city,
                  pinCode: pinCode,
                  state: state),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.d),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.vs, horizontal: 20.hs),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.d,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(usgReportDetail["name"],
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                const SVGLoader(image: icons.Icons.rightArrow)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
