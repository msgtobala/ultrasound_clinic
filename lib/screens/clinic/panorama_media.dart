import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/containers/clinic/panorama_media_container.dart';

class PanoramaMediaScreen extends StatelessWidget {
  const PanoramaMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: PanoramaMediaContainer(),
    );
  }
}
