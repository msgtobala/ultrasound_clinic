import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_dashed_input.dart';
import 'package:ultrasound_clinic/widgets/common/custom_elevated_button.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class GenericMediaDialog extends StatefulWidget {
  final String mediaHeading;
  final void Function(File file) onSaveMedia;
  const GenericMediaDialog({
    super.key,
    required this.mediaHeading,
    required this.onSaveMedia,
  });

  @override
  State<GenericMediaDialog> createState() => _GenericMediaDialogState();
}

class _GenericMediaDialogState extends State<GenericMediaDialog> {
  final _picker = ImagePicker();
  File? _image;

  void closeModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onMediaSelected(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    final image = File(pickedFile!.path);
    setState(() {
      _image = image;
    });
  }

  void onSaveMedia(BuildContext context) {
    if (_image == null) return;
    widget.onSaveMedia(_image!);
    closeModal(context);
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
              widget.mediaHeading,
              style: Theme.of(context).textTheme.headlineSmall,
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
                onPressed: () => onSaveMedia(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
