import 'package:flutter/material.dart';

class ProfileMenuListItem extends StatelessWidget {
  const ProfileMenuListItem({
    super.key,
    required this.leading,
    required this.onTap,
    required this.trailing,
    required this.itemName,
  });

  final void Function() onTap;
  final Image leading;
  final Image trailing;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
