import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/common/panorama_viewer.dart';

class PanoramaViewerContainer extends StatelessWidget {
  const PanoramaViewerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const PanoramaViewer(
      imagePath:
          'https://raw.githubusercontent.com/ShreyaAmbaliya/panorama_viewer_plus/main/example/assets/test.jpg',
      showCloseButton: false,
    );
  }
}
