import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:ultrasound_clinic/constants/enums/role_enum.dart';
import 'package:ultrasound_clinic/models/auth/user_model.dart';
import 'package:ultrasound_clinic/resources/strings.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Add this line
  final log = CustomLogger.getLogger('AuthService');

  // Private constructor
  FirebaseAuthService._privateConstructor();

  // Static instance variable
  static final FirebaseAuthService _instance =
      FirebaseAuthService._privateConstructor();

  // Factory constructor to return the same instance
  factory FirebaseAuthService() {
    return _instance;
  }

  // Stream to listen to authentication state changes
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      throw Exception(Strings.invalidCredentials);
    } catch (e) {
      throw Exception(Strings.anErrorOccurred);
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
    String phone,
    String role,
    String clinicId,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final bool isClinic = role == UserRoleEnum.clinic.roleName ? true : false;
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': userName,
        'email': email,
        'role': role,
        'phone': phone,
        'clinics': isClinic ? [clinicId] : [],
      });
      if (role == UserRoleEnum.clinic.roleName) {
        await _firestore.collection('clinics').doc(clinicId).set({
          'uid': clinicId,
          'email': email,
          'clinicId': clinicId,
          'clinicName': userName,
          'images': [],
        });
      }
      return userCredential;
    } on FirebaseAuthException {
      log.e('Error signing up: ');
      throw Exception(Strings.invalidCredentials);
    } catch (e) {
      throw Exception(Strings.anErrorOccurred);
    }
  }

  // Sign out
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      log.e('Error signing out: $e');
      return false;
    }
  }

  // Fetch user role from Firestore
  Future<String> getUserRole(User user) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc['role'] ?? 'patient';
      } else {
        return 'patient'; // default role if no data found
      }
    } catch (e) {
      log.e('Error fetching user role: $e');
      rethrow;
    }
  }

  // Fetch user from Firebase
  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      log.e('Error fetching user: $e');
      rethrow;
    }
  }

  Future<bool> updateUserClinics(String uid, List<String> clinics) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'clinics': clinics,
      });
      log.i('Clinics updated successfully for user $uid');
      return true;
    } catch (e) {
      log.e('Error updating clinics for user $uid: $e');
      return false;
    }
  }

  // Forgot Password: Send Password Reset Email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      log.e("Error sending password reset email: $e");
      return false;
    }
  }
}
