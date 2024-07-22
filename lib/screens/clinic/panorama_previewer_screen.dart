import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/widgets/common/panorama_previewer.dart';

class PanoramaPreviewerScreen extends StatefulWidget {
  const PanoramaPreviewerScreen({super.key});

  @override
  State<PanoramaPreviewerScreen> createState() =>
      _PanoramaPreviewerScreenState();
}

class _PanoramaPreviewerScreenState extends State<PanoramaPreviewerScreen> {
  List<PanoramaImageModel> _clinicImages = [];
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final List<PanoramaImageModel> images =
        ModalRoute.of(context)!.settings.arguments as List<PanoramaImageModel>;
    setState(() {
      _clinicImages = images;
    });
  }

  void onForward() {
    if (_selectedIndex < _clinicImages.length - 1) {
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

  void onClose(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _clinicImages.isNotEmpty
          ? PanoramaPreViewer(
              imagePath: _clinicImages[_selectedIndex].imageURL,
              sceneName: _clinicImages[_selectedIndex].sceneName,
              showCloseButton: true,
              onClose: () => onClose(context),
              onForward: onForward,
              onBackward: onBackward,
            )
          : const Center(
              child: Text('No images to preview'),
            ),
    );
  }
}
