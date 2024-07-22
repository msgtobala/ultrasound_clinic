import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Stream<List<StaffModel>> getStaffsStream(String clinicId) {
    return _firestore.fireStore
        .collection('clinics')
        .doc(clinicId)
        .collection('staffs')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                StaffModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<List<StaffModel>> getStaffs(String clinicId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('staffs')
          .get();

      List<StaffModel> staffs = querySnapshot.docs.map((doc) {
        return StaffModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return staffs;
    } catch (e) {
      log.e('Error getting staffs: $e');
      return [];
    }
  }

  Future<bool> updateStaff(
    String clinicId,
    String staffId,
    Map<String, dynamic> updatedData,
    File? file,
  ) async {
    try {
      if (file != null) {
        final imageURL = await _firebaseStorage.uploadFile(
          file,
          'clinics/$clinicId/staffs',
          staffId,
        );
        updatedData['imageUrl'] = imageURL;
      }
      await _firestore.fireStore
          .collection('clinics')
          .doc(clinicId)
          .collection('staffs')
          .doc(staffId)
          .update(updatedData);
      log.i('Staff updated successfully');
      return true;
    } catch (e) {
      log.e('Failed to update staff: $e');
      return false;
    }
  }
}
