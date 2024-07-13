import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_image_carousel.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/panorama_actions.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/panorama_draggable_area.dart';

class PanoramaMedia extends StatelessWidget {
  const PanoramaMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 25),
            child: PanoramaActions(
              text: Strings.enterClinicPhotos,
              icon: icons.Icons.edit,
              iconText: Strings.preview,
              onTap: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.hs),
            child: CustomImageCarousel(
              items: constants.carouselItems,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 25),
            child: PanoramaActions(
              text: Strings.availableScreens,
              iconData: Icons.upload,
              iconText: Strings.upload,
              onTap: () {},
            ),
          ),
          // PanoramaDraggableArea(),
          SizedBox(
            height: 235.h,
            child: const PanoramaDraggableArea(),
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
