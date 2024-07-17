import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ultrasound_clinic/constants/constants.dart';
import 'package:ultrasound_clinic/core/services/firebase/firebase_auth_service.dart';
import 'package:ultrasound_clinic/core/services/firebase/firebase_storage_service.dart';
import 'package:ultrasound_clinic/models/auth/auth_model.dart';
import 'package:ultrasound_clinic/models/auth/user_model.dart';
import 'package:ultrasound_clinic/utils/error/parse_exception.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';
import 'package:ultrasound_clinic/utils/shared_preference/shared_preference.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = true;
  UserModel? _currentUser;
  bool _loggedInStatus = false;

  final log = CustomLogger.getLogger('AuthProvider');
  final storageService = FirebaseStorageService();

  User? get user => _user;
  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;
  bool get loggedInStatus => _loggedInStatus;

  AuthProvider() {
    _delayUserCheck();
  }

  Future<void> _delayUserCheck() async {
    await Future.delayed(const Duration(seconds: 1));
    _checkUser();
  }

  Future<void> _checkUser() async {
    final User? user = FirebaseAuthService().currentUser;
    if (user != null) {
      await user.reload();
      final User? reloadedUser = FirebaseAuthService().currentUser;
      final loggedInStatuses = await SharedPreferencesUtils().getMapPrefs(
        constants.loggedInStatusFlag,
      );
      final loggedInStatus = loggedInStatuses.status
          ? loggedInStatuses.value[user.uid] ?? false
          : false;
      if (loggedInStatus) {
        final loggedUser = await FirebaseAuthService().getUser(user.uid);
        _currentUser = UserModel(
          uid: loggedUser.uid,
          name: loggedUser.name,
          email: loggedUser.email,
          role: loggedUser.role,
          phone: loggedUser.phone,
          clinics: loggedUser.clinics,
          profileUrl: user.photoURL,
          state: loggedUser.state,
          city: loggedUser.city,
          address: loggedUser.address,
        );
      }
      _loggedInStatus = loggedInStatus;
      _user = reloadedUser;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<AuthModel> signUp(
    String userName,
    String email,
    String password,
    String phone,
    String role,
  ) async {
    try {
      final credential = await FirebaseAuthService()
          .signUpWithEmailAndPassword(userName, email, password, phone, role);
      return AuthModel.success(
        userName: userName,
        email: email,
        password: password,
        credential: credential.credential,
        isEmailVerified: credential.user!.emailVerified,
        userId: credential.user!.uid,
        phoneNumber: '',
        imageUrl: credential.user!.photoURL ?? '',
        role: role,
      );
    } catch (e) {
      log.e(e);
      return AuthModel.error(message: parseErrorMessage(e.toString()));
    }
  }

  Future<AuthModel> signIn(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuthService().signInWithEmailAndPassword(
        email,
        password,
      );
      if (userCredential.user != null) {
        final loggedUser =
            await FirebaseAuthService().getUser(userCredential.user!.uid);
        _currentUser = loggedUser;
        if (loggedUser.uid != '') {
          return AuthModel.success(
            userName: loggedUser.name,
            email: email,
            password: password,
            credential: userCredential.credential,
            isEmailVerified: userCredential.user!.emailVerified,
            userId: userCredential.user!.uid,
            phoneNumber: loggedUser.phone,
            imageUrl: userCredential.user!.photoURL ?? '',
            role: loggedUser.role,
          );
        }
      }
      // notifyListeners();
      return AuthModel.error(message: 'An error occurred!');
    } catch (e) {
      log.i('Error fetching user: $e');
      return AuthModel.error(message: parseErrorMessage(e.toString()));
    }
  }

  Future<bool> saveUser(Map<String, String> data, File? profile) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? url = user?.photoURL;
    if (user != null) {
      try {
        // If profile is not null, upload the new picture to storage and get the URL
        if (profile != null) {
          url = await storageService.uploadFile(
            profile,
            'users/${user.uid}/profile',
            user.uid,
          );
        }

        // Update the user's profile
        await user.updateProfile(displayName: data['name'], photoURL: url);
        await user.reload();
        user = FirebaseAuth.instance.currentUser!;

        // Update Firestore document
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        data.removeWhere((key, value) => value.isEmpty);
        await userRef.update(data);

        // Fetch the updated user data
        final loggedUser = await FirebaseAuthService().getUser(user.uid);

        // Update the current user model
        _currentUser = UserModel(
          uid: loggedUser.uid,
          name: loggedUser.name,
          email: loggedUser.email,
          role: loggedUser.role,
          phone: loggedUser.phone,
          address: loggedUser.address,
          clinics: loggedUser.clinics,
          state: loggedUser.state,
          city: loggedUser.city,
          profileUrl: url,
        );

        notifyListeners();
        return true;
      } catch (e) {
        log.e('Failed to update user: $e');
        throw Exception('Failed to update user');
      }
    }
    return false;
  }

  Future<void> signOut() async {
    _user = null;
    _currentUser = null;
    await FirebaseAuth.instance.signOut();
  }
}
