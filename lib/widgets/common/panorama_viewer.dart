import 'package:flutter/material.dart';

import 'package:panorama_viewer_plus/panorama_viewer_plus.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class PanoramaViewer extends StatelessWidget {
  final String imagePath;

  const PanoramaViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPanoramaViewer(
          imagePath: imagePath,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 30,
          child: SizedBox(
            width: 15.w,
            height: 15.h,
            child: const SVGLoader(
              image: icons.Icons.close,
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
                    SizedBox(
                      width: 14.w,
                      height: 28.h,
                      child: const SVGLoader(image: icons.Icons.back),
                    ),
                    SizedBox(width: 20.w),
                    const Icon(Icons.circle_outlined, color: Colors.white),
                    SizedBox(width: 20.w),
                    Transform.rotate(
                      angle: 3.14,
                      child: SizedBox(
                        width: 14.w,
                        height: 28.h,
                        child: const SVGLoader(image: icons.Icons.back),
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
