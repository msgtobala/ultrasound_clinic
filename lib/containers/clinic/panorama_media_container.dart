import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/firebase/firebase_storage_service.dart';
import 'package:ultrasound_clinic/core/services/panorama/panorama_services.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_shimmer/custom_card_shimmer.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/media_dialog.dart';
import 'package:ultrasound_clinic/widgets/panorama_media/panorama_media.dart';

class PanoramaMediaContainer extends StatefulWidget {
  const PanoramaMediaContainer({super.key});

  @override
  State<PanoramaMediaContainer> createState() => _PanoramaMediaContainerState();
}

class _PanoramaMediaContainerState extends State<PanoramaMediaContainer> {
  final PanoramaService panoramaService = PanoramaService();
  final FirebaseStorageService storageService = FirebaseStorageService();
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

  void onSavePanoramaImage(List<PanoramaImageModel> panoramaImages) async {
    setState(() {
      _clinicImages = panoramaImages;
    });
  }

  void onPanoramaPreview(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ClinicRoutes.panoramaPreviewer, arguments: _clinicImages);
  }

  void onUploadPanoramaImage(bool? isEdit, String? sceneName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaDialog(
          clinicImages: _clinicImages ?? [],
          onSavePanoramaImage: onSavePanoramaImage,
          isEdit: isEdit ?? false,
          editScene: sceneName ?? '',
        );
      },
    );
  }

  void onDeletePanoramaImage(String sceneName) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    final newPanoramaImages = _clinicImages!
        .where((element) => element.sceneName != sceneName)
        .toList();
    await panoramaService.saveClinicImage(clinicId, newPanoramaImages);
    await storageService.deleteFile('clinics/$clinicId/$sceneName');
    setState(() {
      _clinicImages = newPanoramaImages;
    });
  }

  void onReorderPanoramaImage(int oldIndex, int newIndex) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.currentUser!.clinics.first;
    final newPanoramaImages = List<PanoramaImageModel>.from(_clinicImages!);

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = newPanoramaImages.removeAt(oldIndex);
    newPanoramaImages.insert(newIndex, item);
    await panoramaService.saveClinicImage(clinicId, newPanoramaImages);
    setState(() {
      _clinicImages = newPanoramaImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFetching) {
      return const CustomCardShimmer();
    }

    return Column(
      children: [
        PanoramaMedia(
          clinicImages: _clinicImages ?? [],
          onUploadPanoramaImage: onUploadPanoramaImage,
          onPanoramaPreview: onPanoramaPreview,
          onDeletePanoramaImage: onDeletePanoramaImage,
          onReorderPanoramaImage: onReorderPanoramaImage,
        ),
      ],
    );
  }
}
