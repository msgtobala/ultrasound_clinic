import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/resources/images.dart';
import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/fonts.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class CustomAppBarText extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarText({super.key, required this.title, this.showBackButton});

  final String title;
  final bool? showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton ?? false,
      iconTheme: IconThemeData(
        color: ThemeColors.white,
      ),
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.frameBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMediumWhite,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      elevation: 0,
    );
  }
}
