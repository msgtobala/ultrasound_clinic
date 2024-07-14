import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ultrasound_clinic/core/services/firebase/firestore_service.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';

class PanoramaService {
  // Private constructor
  PanoramaService._privateConstructor();

  // Static instance of the class
  static final PanoramaService _instance =
      PanoramaService._privateConstructor();
  static final FireStoreService _fireStoreService = FireStoreService();

  // Factory constructor to return the static instance
  factory PanoramaService() {
    return _instance;
  }

  Future<List<PanoramaImageModel>> getClinicImages(String clinicId) async {
    try {
      // Reference to the clinic document
      DocumentReference clinicRef =
          _fireStoreService.fireStore.collection('clinics').doc(clinicId);

      // Get the clinic document
      DocumentSnapshot clinicDoc = await clinicRef.get();

      // Check if the document exists
      if (!clinicDoc.exists) {
        return [];
      }

      Map<String, dynamic>? clinicData =
          clinicDoc.data() as Map<String, dynamic>?;
      // Get the images field
      List<dynamic>? images = clinicData?['images'];

      // Check if the images field is found and is not empty
      if (images == null || images.isEmpty) {
        return [];
      }

      // Return the list of images
      return images
          .map((image) =>
              PanoramaImageModel.fromMap(image as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching clinic images: $e');
      return [];
    }
  }
}
