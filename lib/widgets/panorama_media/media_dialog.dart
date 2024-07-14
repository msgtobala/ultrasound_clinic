import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

List<String> extractSceneType(List<PanoramaImageModel> clinicImages) {
  final currentClinicImages =
      clinicImages.map((image) => image.sceneName).toList();
  return constants.sceneTypes.where((scene) {
    return !currentClinicImages.contains(scene);
  }).toList();
}

class MediaDialog extends StatefulWidget {
  final List<PanoramaImageModel> clinicImages;
  final void Function(XFile file, String sceneName) onSavePanoramaImage;

  const MediaDialog({
    super.key,
    required this.clinicImages,
    required this.onSavePanoramaImage,
  });

  @override
  State<MediaDialog> createState() => _MediaDialogState();
}

class _MediaDialogState extends State<MediaDialog> {
  final _picker = ImagePicker();
  XFile? _image;
  String _sceneName = '';
  bool _isUploading = false;

  void closeModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onDropDownSelected(String? value) {
    setState(() {
      _sceneName = value ?? '';
    });
  }

  void onMediaSelected(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    final image = XFile(pickedFile!.path);
    setState(() {
      _image = image;
    });
  }

  void onSave() async {
    if (_image != null && _sceneName.isNotEmpty) {
      // widget.onSavePanoramaImage(_image!, _sceneName);
      // closeModal(context);
    }
  }

  @override
  void didUpdateWidget(MediaDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.d),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: const SVGLoader(image: icons.Icons.closeRed),
                onTap: () => closeModal(context),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              Strings.uploadClinicPicture,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            DropdownMenu(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.d),
                ),
              ),
              textStyle: Theme.of(context).textTheme.bodyMedium,
              dropdownMenuEntries: extractSceneType(widget.clinicImages)
                  .map(
                    (scene) => DropdownMenuEntry(value: scene, label: scene),
                  )
                  .toList(),
              label: Text(
                Strings.mediaType,
                style: Theme.of(context).textTheme.displayMediumGray,
              ),
              onSelected: onDropDownSelected,
            ),
            SizedBox(height: 20.h),
            if (_image == null)
              Column(
                children: [
                  CustomDashedInput(
                    text: Strings.gallery,
                    onTap: () => onMediaSelected(ImageSource.gallery),
                  ),
                  SizedBox(height: 20.h),
                  CustomDashedInput(
                    text: Strings.camera,
                    onTap: () => onMediaSelected(ImageSource.camera),
                  ),
                ],
              ),
            if (_image != null) Image.file(File(_image!.path)),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.save,
                onPressed: onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
