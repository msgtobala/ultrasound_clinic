import 'dart:io';

import 'package:ultrasound_clinic/core/services/firebase/firebase_storage_service.dart';
import 'package:ultrasound_clinic/core/services/firebase/firestore_service.dart';
import 'package:ultrasound_clinic/models/common/staff_model.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class StaffService {
  StaffService._privateConstructor();
  final log = CustomLogger.getLogger('StaffService');

  static final StaffService _instance = StaffService._privateConstructor();

  final FireStoreService _firestore = FireStoreService();
  static final FirebaseStorageService _firebaseStorage =
      FirebaseStorageService();

  factory StaffService() {
    return _instance;
  }

  Future<String?> createStaff(
    String clinicId,
    Map<String, dynamic> staff,
    File file,
  ) async {
    try {
      String staffId = _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('staffs')
          .doc()
          .id;
      final imageURL = await _firebaseStorage.uploadFile(
          file, 'clinics/$clinicId/staffs', staffId);
      StaffModel staffModel = StaffModel.fromJson({
        ...staff,
        'uid': staffId,
        'imageUrl': imageURL,
      });
      await _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('staffs')
          .doc(staffId)
          .set({...staffModel.toJson()});

      return staffId;
    } catch (e) {
      log.e('Error creating staff: $e');
      return null;
    }
  }
}
