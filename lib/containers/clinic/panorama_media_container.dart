import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/panorama/panorama_services.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/media_dialog.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/panorama_media.dart';

class PanoramaMediaContainer extends StatefulWidget {
  const PanoramaMediaContainer({super.key});

  @override
  State<PanoramaMediaContainer> createState() => _PanoramaMediaContainerState();
}

class _PanoramaMediaContainerState extends State<PanoramaMediaContainer> {
  final PanoramaService panoramaService = PanoramaService();
  bool _isFetching = true;
  List<PanoramaImageModel>? _clinicImages;

  @override
  void initState() {
    super.initState();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    fetchClinicImages(clinicId);
  }

  void fetchClinicImages(String clinicId) async {
    final images = await panoramaService.getClinicImages(clinicId);
    setState(() {
      _isFetching = false;
      _clinicImages = images;
    });
  }

  void onSavePanoramaImage(XFile file, String sceneName) async {}

  void onUploadPanoramaImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaDialog(
          clinicImages: _clinicImages ?? [],
          onSavePanoramaImage: onSavePanoramaImage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isFetching) {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height -
            (kBottomNavigationBarHeight + 200.h),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      children: [
        PanoramaMedia(
          clinicImages: _clinicImages ?? [],
          onUploadPanoramaImage: onUploadPanoramaImage,
        ),
      ],
    );
  }
}
