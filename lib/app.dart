import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ultrasound_clinic/core/services/http/http_base.dart';
import 'package:ultrasound_clinic/providers/auth_provider.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/routes/routes.dart';
import 'package:ultrasound_clinic/themes/themes.dart';

class UltraSoundClinicApp extends StatelessWidget {
  const UltraSoundClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    HttpBase().setBaseUrl('https://jsonplaceholder.typicode.com');
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: Strings.appName,
        theme: Themes.buildLightTheme(context),
        initialRoute: Routes.initialRoute,
        routes: Routes.buildRoutes,
        onUnknownRoute: Routes.unknownRoute,
      ),
    );
    // return StreamProvider<User?>.value(
    //   value: FirebaseAuthService().user,
    //   initialData: null,
    //   child: const MaterialApp(
    //     home: AuthWrapper(),
    //   ),
    // );
  }
}
