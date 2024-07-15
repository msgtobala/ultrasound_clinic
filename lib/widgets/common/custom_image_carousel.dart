import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/resources/icons.dart' as icons;
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/widgets/common/custom_chip.dart';
import 'package:ultrasound_clinic/widgets/common/svg_loader.dart';

class CustomImageCarousel extends StatefulWidget {
  final List<PanoramaImageModel> items;

  const CustomImageCarousel({super.key, required this.items});

  @override
  State<CustomImageCarousel> createState() => _CustomImageCarouselState();
}

class _CustomImageCarouselState extends State<CustomImageCarousel> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            CarouselSlider.builder(
              carouselController: _controller,
              options: CarouselOptions(
                clipBehavior: Clip.none,
                aspectRatio: 16 / 9,
                viewportFraction: widget.items.length == 1 ? 0.97 : 0.85,
                padEnds: false,
                initialPage: 0,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
              ),
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final item = widget.items[index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(item.imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 15.hs, bottom: 5.vs),
                      child: CustomChip(label: item.sceneName),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _controller.previousPage(),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColors.black100,
                  ),
                  child: const Center(
                    child: SVGLoader(image: icons.Icons.back),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => _controller.nextPage(),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColors.black100,
                  ),
                  child: Transform.rotate(
                    angle: 3.14,
                    child: const Center(
                      child: SVGLoader(image: icons.Icons.back),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}