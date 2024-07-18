import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<DoctorModel>> getDoctors(String clinicId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('doctors')
          .get();

      List<DoctorModel> doctors = querySnapshot.docs.map((doc) {
        return DoctorModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return doctors;
    } catch (e) {
      log.e('Error getting doctors: $e');
      return [];
    }
  }
}
