import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/core/services/firebase/firebase_storage_service.dart';
import 'package:ultrasound_clinic/core/services/panorama/panorama_services.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
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
  final void Function(List<PanoramaImageModel> panoramaImages)
      onSavePanoramaImage;
  final bool isEdit;
  final String editScene;

  const MediaDialog({
    super.key,
    required this.clinicImages,
    required this.onSavePanoramaImage,
    this.isEdit = false,
    this.editScene = '',
  });

  @override
  State<MediaDialog> createState() => _MediaDialogState();
}

class _MediaDialogState extends State<MediaDialog> {
  final storageService = FirebaseStorageService();
  final PanoramaService panoramaService = PanoramaService();
  final _picker = ImagePicker();
  File? _image;
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
    final image = File(pickedFile!.path);
    setState(() {
      _image = image;
    });
  }

  void onSave() async {
    final clinicId = Provider.of<AuthProvider>(context, listen: false)
        .currentUser!
        .clinics
        .first;
    if (_image != null && _sceneName.isNotEmpty) {
      setState(() {
        _isUploading = true;
      });
      final url = await storageService.uploadFile(
        _image!,
        'clinics/$clinicId',
        _sceneName,
      );
      setState(() {
        _isUploading = false;
      });
      final newPanoramaClinicImages = [
        PanoramaImageModel(
          sceneName: _sceneName,
          imageURL: url,
        ),
        ...widget.clinicImages,
      ];
      await panoramaService.saveClinicImage(clinicId, newPanoramaClinicImages);
      widget.onSavePanoramaImage(newPanoramaClinicImages);
      closeModal(context);
    }
  }

  void onEdit() async {
    final clinicId = Provider.of<AuthProvider>(context, listen: false)
        .currentUser!
        .clinics
        .first;
    if (_image != null && widget.editScene.isNotEmpty) {
      setState(() {
        _isUploading = true;
      });
      final url = await storageService.uploadFile(
        _image!,
        'clinics/$clinicId',
        widget.editScene,
      );
      setState(() {
        _isUploading = false;
      });
      final editedPanoramaImage = PanoramaImageModel(
        sceneName: widget.editScene,
        imageURL: url,
      );
      final newClinicImages = widget.clinicImages
          .map(
            (image) => image.sceneName == widget.editScene
                ? editedPanoramaImage
                : image,
          )
          .toList();
      await panoramaService.saveClinicImage(clinicId, newClinicImages);
      widget.onSavePanoramaImage(newClinicImages);
      closeModal(context);
    }
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
              widget.isEdit
                  ? '${Strings.replace} ${widget.editScene} ${Strings.picture}'
                  : Strings.uploadClinicPicture,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 32.h),
            DropdownMenu(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.d),
                ),
              ),
              textStyle: widget.isEdit
                  ? Theme.of(context).textTheme.displayMediumGray
                  : Theme.of(context).textTheme.bodyMedium,
              dropdownMenuEntries: widget.isEdit
                  ? [
                      DropdownMenuEntry(
                          value: widget.editScene, label: widget.editScene)
                    ]
                  : extractSceneType(widget.clinicImages)
                      .map(
                        (scene) =>
                            DropdownMenuEntry(value: scene, label: scene),
                      )
                      .toList(),
              label: Text(
                Strings.mediaType,
                style: Theme.of(context).textTheme.displayMediumGray,
              ),
              onSelected: onDropDownSelected,
              initialSelection: widget.isEdit ? widget.editScene : '',
              enabled: widget.isEdit ? false : true,
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
            if (!widget.isEdit)
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: Strings.save,
                  onPressed:
                      _image != null && _sceneName.isNotEmpty ? onSave : null,
                  isLoading: _isUploading,
                ),
              ),
            if (widget.isEdit)
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: Strings.edit,
                  onPressed: widget.editScene.isNotEmpty && _image != null
                      ? onEdit
                      : null,
                  isLoading: _isUploading,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
