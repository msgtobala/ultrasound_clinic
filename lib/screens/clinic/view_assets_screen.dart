import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';

class ViewAssetsScreen extends StatelessWidget {
  const ViewAssetsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String imageURL = arguments['imageURL']!;
    final String text = arguments['text']!;

    return Scaffold(
      appBar: CustomAppBarText(
        title: text,
        showBackButton: true,
      ),
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
