import 'package:flutter/material.dart';

class ViewAssetsScreen extends StatelessWidget {
  const ViewAssetsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String imageURL =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Image.network(
        imageURL,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
