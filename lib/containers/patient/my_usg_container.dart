import 'package:flutter/material.dart';

import 'package:ultrasound_clinic/core/services/usg/usg_service.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';

class MyUsgContainer extends StatefulWidget {
  const MyUsgContainer({super.key});

  @override
  State<MyUsgContainer> createState() => _MyUsgContainerState();
}

class _MyUsgContainerState extends State<MyUsgContainer> {
  final USGService usgService = USGService();
  bool _isLoading = false;
  List<UserUSGModel> _usg = [];
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchUSGByDate(currentDate);
  }

  void fetchUSGByDate(DateTime date) async {
    // final response = await usgService.getUserUSGByDate(date);
    // setState(() {
    //   _isLoading = false;
    //   _usg = response;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('My Usg Container'),
    );
  }
}
