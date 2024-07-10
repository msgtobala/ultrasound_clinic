import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    } catch (e) {
      log.i('Error signing in: $e');
      throw e;
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
    String phone,
    String role,
  ) async {
    try {
      // TODO(Balaji): what if user signs up with phone no?
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // await userCredential.user!
      //     .sendEmailVerification(); // Send email verification
      // After successful signup, store additional user information in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role,
        'phone': phone,
        'clinics': ['XVL560'],
      });
      return userCredential;
    } catch (e) {
      log.i('Error signing up: $e');
      return Future.error(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log.i('Error signing out: $e');
      throw e;
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
      log.i('Error fetching user role: $e');
      throw e;
    }
  }
}
