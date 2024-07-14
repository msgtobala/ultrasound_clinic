import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ultrasound_clinic/core/services/firebase/firestore_service.dart';
import 'package:ultrasound_clinic/models/common/panorama_image_model.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class PanoramaService {
  // Private constructor
  PanoramaService._privateConstructor();
  final log = CustomLogger.getLogger('PanoramaService');

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
      log.e('Error fetching clinic images: $e');
      return [];
    }
  }

  Future<void> saveClinicImage(
    String clinicId,
    List<PanoramaImageModel> panoramaImages,
  ) async {
    try {
      // Reference to the clinic document
      DocumentReference clinicRef =
          _fireStoreService.fireStore.collection('clinics').doc(clinicId);

      // Get the clinic document
      DocumentSnapshot clinicDoc = await clinicRef.get();

      // Check if the document exists
      if (!clinicDoc.exists) {
        return;
      }

      // Update the clinic document with the new image
      await clinicRef.update(
          {'images': panoramaImages.map((image) => image.toMap()).toList()});
    } catch (e) {
      log.e('Error saving clinic image: $e');
    }
  }

  Future<void> deleteClinicImage(
    String clinicId,
    PanoramaImageModel panoramaImage,
  ) async {
    try {
      // Reference to the clinic document
      DocumentReference clinicRef =
          _fireStoreService.fireStore.collection('clinics').doc(clinicId);

      // Get the clinic document
      DocumentSnapshot clinicDoc = await clinicRef.get();

      // Check if the document exists
      if (!clinicDoc.exists) {
        return;
      }

      Map<String, dynamic>? clinicData =
          clinicDoc.data() as Map<String, dynamic>?;
      // Get the images field
      List<dynamic>? images = clinicData?['images'];

      // Check if the images field is found and is not empty
      if (images == null || images.isEmpty) {
        return;
      }

      // Remove the image from the list
      images.remove(panoramaImage.toMap());

      // Update the clinic document with the new image
      await clinicRef.update({'images': images});
    } catch (e) {
      log.e('Error deleting clinic image: $e');
    }
  }
}
