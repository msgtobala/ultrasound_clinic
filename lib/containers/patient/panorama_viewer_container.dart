import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/panorama/panorama_services.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_shimmer/custom_card_shimmer.dart';
import 'package:ultrasound_clinic/widgets/common/panorama_previewer.dart';

class PanoramaViewerContainer extends StatefulWidget {
  const PanoramaViewerContainer({super.key});

  @override
  State<PanoramaViewerContainer> createState() =>
      _PanoramaViewerContainerState();
}

class _PanoramaViewerContainerState extends State<PanoramaViewerContainer> {
  final PanoramaService panoramaService = PanoramaService();
  bool _isLoading = false;
  List<PanoramaImageModel> _panoramaImages = [];
  int _selectedIndex = 0;

  Future<void> fetchPanoramaImages() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final clinicId = authProvider.selectedClinicCode;

    setState(() {
      _isLoading = true;
    });

    // Fetch panorama images from API
    final clinicImages = await panoramaService.getClinicImages(clinicId);

    setState(() {
      _isLoading = false;
      _panoramaImages = clinicImages;
    });
  }

  void onForward() {
    if (_selectedIndex < _panoramaImages.length - 1) {
      setState(() {
        _selectedIndex++;
      });
    }
  }

  void onBackward() {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex--;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchPanoramaImages();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        child: const CustomCardShimmer(),
      );
    }

    if (_panoramaImages.isEmpty) {
      return Center(
        child: Text(
          Strings.noPanoramaImagesFound,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    return PanoramaPreViewer(
      imagePath: _panoramaImages[_selectedIndex].imageURL,
      sceneName: _panoramaImages[_selectedIndex].sceneName,
      showCloseButton: false,
      isPreview: true,
      onBackward: onBackward,
      onForward: onForward,
    );
  }
}
