import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class PanoramaDraggableArea extends StatefulWidget {
  final List<PanoramaImageModel> items;
  final void Function(bool? isEdit, String? sceneName) onUploadPanoramaImage;
  final Function(String sceneName) onDeletePanoramaImage;
  final Function(int oldIndex, int newIndex) onReorderPanoramaImage;

  const PanoramaDraggableArea({
    super.key,
    required this.items,
    required this.onUploadPanoramaImage,
    required this.onDeletePanoramaImage,
    required this.onReorderPanoramaImage,
  });

  @override
  State<PanoramaDraggableArea> createState() => _PanoramaDraggableAreaState();
}

class _PanoramaDraggableAreaState extends State<PanoramaDraggableArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: ReorderableListView.builder(
        proxyDecorator: (child, index, animation) => Material(
          type: MaterialType.transparency,
          child: child,
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            key: ValueKey(widget.items[index].sceneName),
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColors.lightBlue),
              borderRadius: BorderRadius.circular(10.d),
            ),
            child: ListTile(
              enableFeedback: false,
              dense: false,
              leading: const SVGLoader(image: icons.Icons.drag),
              title: Text(widget.items[index].sceneName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: const SVGLoader(image: icons.Icons.delete),
                    onTap: () => widget
                        .onDeletePanoramaImage(widget.items[index].sceneName),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => widget.onUploadPanoramaImage(
                      true,
                      widget.items[index].sceneName,
                    ),
                    child: const SVGLoader(image: icons.Icons.edit),
                  )
                ],
              ),
            ),
          );
        },
        onReorder: widget.onReorderPanoramaImage,
      ),
    );
  }
}
