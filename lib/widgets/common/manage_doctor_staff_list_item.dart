import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class ManageDoctorStaffListItem extends StatelessWidget {
  const ManageDoctorStaffListItem({
    super.key,
    required this.doctorName,
    required this.position,
    this.clinicName,
  });

  final String doctorName;
  final String position;
  final String? clinicName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 30,
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctorName,
                    style: Theme.of(context).textTheme.headlineSmall),
                Text(
                  clinicName != null ? "$position-$clinicName" : position,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SVGLoader(
              image: Images.editIcon,
              width: 30.w,
              height: 30.w,
            ),
          ),
        ],
      ),
    );
  }
}
