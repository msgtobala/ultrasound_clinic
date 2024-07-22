import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:panorama_viewer/panorama_viewer.dart';

import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class PanoramaPreViewer extends StatefulWidget {
  final String imagePath;
  final bool? showCloseButton;
  final Function()? onClose;
  final Function()? onForward;
  final Function()? onBackward;

  const PanoramaPreViewer({
    super.key,
    required this.imagePath,
    this.showCloseButton,
    this.onClose,
    this.onForward,
    this.onBackward,
  });

  @override
  State<PanoramaPreViewer> createState() => _PanoramaPreViewerState();
}

class _PanoramaPreViewerState extends State<PanoramaPreViewer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PanoramaViewer(
          onImageLoad: () {
            print('Image loaded');
          },
          child: Image(
            image: CachedNetworkImageProvider(widget.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        if (widget.showCloseButton == true)
          Positioned(
            top: 80,
            left: 30,
            child: InkWell(
              onTap: widget.onClose,
              child: SizedBox(
                width: 15.w,
                height: 15.h,
                child: const SVGLoader(
                  image: icons.Icons.close,
                ),
              ),
            ),
          ),
        Positioned(
          bottom: kBottomNavigationBarHeight - 30.h,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.5),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
            width: MediaQuery.of(context).size.width * 0.92,
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 25.h,
                  child: const SVGLoader(image: icons.Icons.menu),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: widget.onBackward,
                      child: SizedBox(
                        width: 14.w,
                        height: 28.h,
                        child: const SVGLoader(image: icons.Icons.back),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    const Icon(Icons.circle_outlined, color: Colors.white),
                    SizedBox(width: 20.w),
                    Transform.rotate(
                      angle: 3.14,
                      child: InkWell(
                        onTap: widget.onForward,
                        child: SizedBox(
                          width: 14.w,
                          height: 28.h,
                          child: const SVGLoader(image: icons.Icons.back),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 50.w,
                  height: 30.h,
                  child: const SVGLoader(image: icons.Icons.view360White),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
