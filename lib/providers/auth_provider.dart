import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:ultrasound_clinic/core/services/firebase/firebase_auth_service.dart';
import 'package:ultrasound_clinic/models/auth/auth_model.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = true;
  final log = CustomLogger.getLogger('AuthProvider');

  User? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _delayUserCheck();
  }

  Future<void> _delayUserCheck() async {
    await Future.delayed(const Duration(seconds: 2));
    _checkUser();
  }

  Future<void> _checkUser() async {
    final User? user = FirebaseAuthService().currentUser;
    if (user != null) {
      await user.reload();
      final User? reloadedUser = FirebaseAuthService().currentUser;
      _user = reloadedUser;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<AuthModel> signUp(
    String userName,
    String email,
    String password,
    String role,
  ) async {
    try {
      final credential = await FirebaseAuthService()
          .signUpWithEmailAndPassword(userName, email, password, role);
      return AuthModel.success(
        userName: userName,
        email: email,
        password: password,
        credential: credential.credential,
        isEmailVerified: credential.user!.emailVerified,
        userId: credential.user!.uid,
        phoneNumber: '',
        imageUrl: credential.user!.photoURL ?? '',
      );
    } catch (e) {
      log.e(e);
      return AuthModel.error(message: 'An error occurred!');
    }
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // print(userCredential);
    // _checkUser();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.signOut();
    _checkUser();
  }
}
