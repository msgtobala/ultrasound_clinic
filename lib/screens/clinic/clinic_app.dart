import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ultrasound_clinic/routes/clinic_routes.dart';
import 'package:ultrasound_clinic/themes/themes.dart';

// This function will handle background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  // You can process the message here, or show a notification
}

class ClinicApp extends StatefulWidget {
  const ClinicApp({super.key});

  @override
  _ClinicAppState createState() => _ClinicAppState();
}

class _ClinicAppState extends State<ClinicApp> {
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    await _setupFirebaseMessaging();
  }

  Future<void> _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // Get the token
      String? token = await messaging.getToken();
      print('FCM Token: $token');

      // Save this token to Firestore for the current user
      await _saveTokenToFirestore(token);

      // Handle incoming messages when the app is in the foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
          // Show the notification to the user
          // You may want to use a plugin like flutter_local_notifications for this
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _saveTokenToFirestore(String? token) async {
    if (token != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set({'fcmToken': token}, SetOptions(merge: true));
      } else {
        print('No user is currently signed in.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.buildLightTheme(context),
      initialRoute: ClinicRoutes.initialClinicRoute,
      routes: ClinicRoutes.buildClinicRoutes,
      onUnknownRoute: ClinicRoutes.unknownRoute,
    );
  }
}
