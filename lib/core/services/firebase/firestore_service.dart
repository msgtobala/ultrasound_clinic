import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  // Private constructor
  FireStoreService._privateConstructor();

  // Static instance variable
  static final FireStoreService _instance =
      FireStoreService._privateConstructor();

  // Factory constructor to return the same instance
  factory FireStoreService() {
    return _instance;
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Example: Method to fetch documents from a collection
  Future<List<DocumentSnapshot>> fetchDocumentsFromCollection(
      String collectionPath) async {
    try {
      QuerySnapshot querySnapshot =
          await _fireStore.collection(collectionPath).get();
      return querySnapshot.docs;
    } catch (e) {
      // Handle errors or return an empty list
      print(e); // Consider using a logging package for better logging
      return [];
    }
  }

  // Add more methods for other common queries
}
