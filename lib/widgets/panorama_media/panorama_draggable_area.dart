import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class PanoramaDraggableArea extends StatefulWidget {
  const PanoramaDraggableArea({super.key});

  @override
  State<PanoramaDraggableArea> createState() => _PanoramaDraggableAreaState();
}

class _PanoramaDraggableAreaState extends State<PanoramaDraggableArea> {
  final List<String> items = ['Reception', 'Waiting room', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: ReorderableListView.builder(
        proxyDecorator: (child, index, animation) => Material(
          type: MaterialType.transparency,
          child: child,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            key: ValueKey(items[index]),
            decoration: BoxDecoration(
              border: Border.all(color: ThemeColors.lightBlue),
              borderRadius: BorderRadius.circular(10.d),
            ),
            child: ListTile(
              enableFeedback: false,
              dense: false,
              leading: const SVGLoader(image: icons.Icons.drag),
              title: Text(items[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: const SVGLoader(image: icons.Icons.delete),
                    onTap: () {},
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    child: const SVGLoader(image: icons.Icons.edit),
                    onTap: () {},
                  )
                ],
              ),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final String item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
