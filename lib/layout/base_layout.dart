import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/responsiveness.dart';
import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({
    super.key,
    required this.child,
    this.hideMeta = false,
    required this.pageTitle,
    required this.pageDescription,
    this.offset = const Offset(0, -40),
  });

  final Widget child;
  final String pageTitle;
  final String pageDescription;
  final Offset? offset;
  final bool? hideMeta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 380.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      Images.layoutBackground,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  if (hideMeta != false)
                    Positioned(
                      top: 120.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pageTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            pageDescription,
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumStrongWhite,
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Transform.translate(
              offset: offset ?? Offset(0, -40.h),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
