import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_shimmer/custom_shimmer.dart';

class CustomCardShimmer extends StatelessWidget {
  const CustomCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerPro.generated(
      light: ShimmerProLight.lighter,
      height: MediaQuery.of(context).size.height * 0.15,
      scaffoldBackgroundColor: ThemeColors.white,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerPro.sized(
              light: ShimmerProLight.lighter,
              scaffoldBackgroundColor: ThemeColors.white,
              height: 80,
              width: 80,
              borderRadius: 50,
            ),
            ShimmerPro.text(
              light: ShimmerProLight.lighter,
              scaffoldBackgroundColor: ThemeColors.white,
              width: MediaQuery.of(context).size.width * 0.5,
            )
          ],
        ),
      ),
    );
  }
}
