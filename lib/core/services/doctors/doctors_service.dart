import 'dart:io';

import 'package:ultrasound_clinic/core/services/firebase/firebase_storage_service.dart';
import 'package:ultrasound_clinic/core/services/firebase/firestore_service.dart';
import 'package:ultrasound_clinic/models/common/doctor_model.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class DoctorService {
  DoctorService._privateConstructor();
  final log = CustomLogger.getLogger('DoctorService');

  static final DoctorService _instance = DoctorService._privateConstructor();

  final FireStoreService _firestore = FireStoreService();
  static final FirebaseStorageService _firebaseStorage =
      FirebaseStorageService();

  factory DoctorService() {
    return _instance;
  }

  Future<String?> createDoctor(
    String clinicId,
    Map<String, dynamic> doctor,
    File file,
  ) async {
    try {
      String doctorId = _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('doctors')
          .doc()
          .id;
      final imageURL = await _firebaseStorage.uploadFile(
          file, 'clinics/$clinicId/doctors', doctorId);
      DoctorModel doctorModel = DoctorModel.fromJson({
        ...doctor,
        'uid': doctorId,
        'imageUrl': imageURL,
      });
      await _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('doctors')
          .doc(doctorId)
          .set({...doctorModel.toJson()});

      return doctorId;
    } catch (e) {
      log.e('Error creating doctor: $e');
      return null;
    }
  }

  Stream<List<DoctorModel>> getDoctorsStream(String clinicId) {
    return _firestore.fireStore
        .collection('clinics')
        .doc(clinicId)
        .collection('doctors')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DoctorModel.fromJson(doc.data()))
            .toList());
  }

  Future<bool> updateDoctor(
    String clinicId,
    String doctorId,
    Map<String, dynamic> updatedData,
    File? file,
  ) async {
    try {
      if (file != null) {
        final imageURL = await _firebaseStorage.uploadFile(
          file,
          'clinics/$clinicId/doctors',
          doctorId,
        );
        updatedData['imageUrl'] = imageURL;
      }
      await _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('doctors')
          .doc(doctorId)
          .update(updatedData);
      log.i('Doctor updated successfully');
      return true;
    } catch (e) {
      log.e('Failed to update doctor: $e');
      return false;
    }
  }

  Future<bool> deleteDoctor(String clinicId, String doctorId) async {
    try {
      await _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('doctors')
          .doc(doctorId)
          .delete();
      log.i('Doctor deleted successfully');
      return true;
    } catch (e) {
      log.e('Failed to delete doctor: $e');
      return false;
    }
  }
}
