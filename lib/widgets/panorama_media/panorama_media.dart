import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_image_carousel.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/panorama_actions.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/panorama_draggable_area.dart';

class PanoramaMedia extends StatelessWidget {
  final List<PanoramaImageModel> clinicImages;
  final void Function(bool? isEdit, String? sceneName) onUploadPanoramaImage;
  final Function(BuildContext context) onPanoramaPreview;
  final Function(String sceneName) onDeletePanoramaImage;
  final Function(int oldIndex, int newIndex) onReorderPanoramaImage;

  const PanoramaMedia({
    super.key,
    required this.clinicImages,
    required this.onUploadPanoramaImage,
    required this.onPanoramaPreview,
    required this.onDeletePanoramaImage,
    required this.onReorderPanoramaImage,
  });

  @override
  Widget build(BuildContext context) {
    if (clinicImages.isEmpty) {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.enterClinicPhotos,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 26.h),
            CustomDashedInput(
              text: Strings.uploadClinicPicture,
              onTap: () => onUploadPanoramaImage(null, null),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 25),
          child: PanoramaActions(
            text: Strings.enterClinicPhotos,
            icon: icons.Icons.edit,
            iconText: Strings.preview,
            hidePillButton: false,
            onTap: () => onPanoramaPreview(context),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.hs),
          child: CustomImageCarousel(
            items: clinicImages,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 25),
          child: PanoramaActions(
            text: Strings.availableScreens,
            iconData: Icons.upload,
            iconText: Strings.upload,
            hidePillButton: clinicImages.length == constants.maxSceneTypes,
            onTap: () => onUploadPanoramaImage(null, null),
          ),
        ),
        SizedBox(
          height: 235.h,
          child: PanoramaDraggableArea(
            items: clinicImages,
            onUploadPanoramaImage: onUploadPanoramaImage,
            onDeletePanoramaImage: onDeletePanoramaImage,
            onReorderPanoramaImage: onReorderPanoramaImage,
          ),
        ),
        SizedBox(height: 25.h),
      ],
    );
  }
}
