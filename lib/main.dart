import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:ultrasound_clinic/app.dart';
import 'package:ultrasound_clinic/core/services/firebase/firebase_options.dart';
import 'package:ultrasound_clinic/themes/responsiveness.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Responsiveness.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UltraSoundClinicApp());
}
