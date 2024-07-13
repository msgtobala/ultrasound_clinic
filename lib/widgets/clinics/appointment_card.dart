import 'package:flutter/material.dart';

import 'package:pigment/pigment.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String appointmentId;
  final String appointmentTime;
  final String imageUrl;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.appointmentId,
    required this.appointmentTime,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Pigment.fromString('#C9EBFF'),
        ),
      ),
      color: Pigment.fromString('#f7fcff'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text(
                            'Ap.ID - $appointmentId',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: SVGLoader(
                          image: Images.phone,
                          width: 30.w,
                          height: 30.h,
                        ),
                        onPressed: () {
                          // Handle phone button press
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                      color: ThemeColors.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        SVGLoader(
                          image: Images.dateTime,
                          width: 20.w,
                          height: 20.h,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            appointmentTime,
                            style:
                                Theme.of(context).textTheme.displaySmallWhite,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
