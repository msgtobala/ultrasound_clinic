import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/widgets/common/pill_action_button.dart';

class PanoramaActions extends StatelessWidget {
  final String text;
  final String iconText;
  final String? icon;
  final IconData? iconData;
  final double? width;
  final bool hidePillButton;
  final void Function() onTap;

  const PanoramaActions({
    super.key,
    required this.text,
    required this.iconText,
    this.icon,
    required this.onTap,
    this.width,
    this.iconData,
    required this.hidePillButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (!hidePillButton)
          PillActionButton(
            text: iconText,
            icon: icon,
            iconData: iconData,
            onTap: onTap,
            width: width,
          ),
      ],
    );
  }
}
