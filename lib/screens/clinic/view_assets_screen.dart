import 'package:flutter/material.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/widgets/common/custom_app_bar_text.dart';

class ViewAssetsScreen extends StatelessWidget {
  const ViewAssetsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String imageURL =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: const CustomAppBarText(
        title: Strings.prescription,
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
