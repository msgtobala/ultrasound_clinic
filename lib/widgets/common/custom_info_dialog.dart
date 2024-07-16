import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;

class CustomInfoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String displayData;
  final void Function(BuildContext context) onClose;
  final void Function(String data) onCopy;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.content,
    required this.displayData,
    required this.onClose,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.d),
      ),
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  displayData,
                  style: Theme.of(context).textTheme.headlineSmallRegularGrey,
                ),
              ),
              IconButton(
                icon: const SVGLoader(image: icons.Icons.copyBlack),
                onPressed: () => onCopy(displayData),
                color: ThemeColors.black,
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => onClose(context),
          child: Text(Strings.close.toUpperCase()),
        ),
      ],
    );
  }
}
