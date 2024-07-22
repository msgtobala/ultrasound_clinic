import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/themes/colors.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class CustomAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isNetwork;
  final double? radius;
  final bool? editMode;
  final Function()? onTap;
  final bool? isContrast;

  const CustomAvatar({
    super.key,
    required this.imageUrl,
    this.isNetwork = true,
    this.radius = 30,
    this.editMode = false,
    this.onTap,
    this.isContrast = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: isNetwork
          ? CachedNetworkImageProvider(imageUrl)
          : AssetImage(imageUrl) as ImageProvider,
      radius: radius?.d,
      backgroundColor: editMode == true
          ? ThemeColors.black.withOpacity(0.5)
          : isContrast == true
              ? ThemeColors.primary
              : ThemeColors.white,
      onBackgroundImageError: (_, __) => const CustomAvatarChild(),
      child: CustomAvatarChild(
        imageURL: imageUrl,
        editMode: editMode,
        onTap: onTap,
        isContrast: isContrast,
      ),
    );
  }
}

class CustomAvatarChild extends StatelessWidget {
  final String? imageURL;
  final bool? editMode;
  final Function()? onTap;
  final bool? isContrast;

  const CustomAvatarChild({
    super.key,
    this.imageURL,
    this.editMode = false,
    this.onTap,
    this.isContrast = false,
  });

  @override
  Widget build(BuildContext context) {
    if (editMode == true) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColors.black.withOpacity(0.4),
          ),
          child: Icon(
            Icons.edit,
            size: 28.ics,
            color: ThemeColors.white,
          ),
        ),
      );
    }

    if (imageURL == null || imageURL!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isContrast == true ? ThemeColors.primary : ThemeColors.white,
        ),
        child: Icon(
          Icons.person,
          size: 35.ics,
          color: isContrast == true ? ThemeColors.white : ThemeColors.primary,
        ),
      );
    }

    return const SizedBox();
  }
}
