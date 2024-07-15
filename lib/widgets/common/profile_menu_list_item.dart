import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

class ProfileMenuListItem extends StatelessWidget {
  const ProfileMenuListItem({
    super.key,
    required this.itemName,
    required this.leading,
    required this.trailing,
    required this.onTap,
  });

  final Image leading;
  final Image trailing;
  final String itemName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.vs,
        horizontal: 0,
      ),
      child: ListTile(
        leading: leading,
        title: Text(
          itemName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
