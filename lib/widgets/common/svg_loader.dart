import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

/// [SVGLoader] this widget is to create an SVG rendering widget from an asset.
/// Use [SVGLoader] like this:
///  ```
/// SVGLoader(
///   image,
///   height: 24,
///   width: 24,
/// )
///  ```
///

class SVGLoader extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;

  const SVGLoader({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
