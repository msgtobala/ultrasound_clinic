import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ultrasound_clinic/core/services/firebase/firebase_storage_service.dart';
import 'package:ultrasound_clinic/models/common/usg_model.dart';
import 'package:ultrasound_clinic/utils/date_time/date_time.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class USGService {
  USGService._privateConstructor();
  final log = CustomLogger.getLogger('USGService');

  // Static instance of the class
  static final USGService _instance = USGService._privateConstructor();
  static final FirebaseStorageService _firebaseStorage =
      FirebaseStorageService();

  // Factory constructor to return the static instance
  factory USGService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createUSG(
    String clinicId,
    String userId,
    Map<String, dynamic> usg,
  ) async {
    try {
      String fileName = generateFileName();
      final prescriptionURL = await _firebaseStorage.uploadFile(
        usg['prescription'],
        'users/$userId/prescriptions/',
        fileName,
      );

      String usgId = _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('usgs')
          .doc()
          .id;
      String userUSGId = _firestore
          .collection('users')
          .doc(userId)
          .collection('userUSG')
          .doc()
          .id;
      USGModel usgModel = USGModel.fromJson({
        ...usg,
        'uid': usgId,
        'userId': userId,
        'prescription': prescriptionURL,
        'usgRefId': userUSGId,
        'receiptUrl': '',
      });
      UserUSGModel userUSGModel = UserUSGModel.fromJson({
        ...usg,
        'uid': userUSGId,
        'prescription': prescriptionURL,
        'refId': usgId,
        'clinicId': clinicId,
        'receiptUrl': ""
      });

      await _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('usg')
          .doc(usgId)
          .set(
        {
          ...usgModel.toJson(),
        },
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('userUSG')
          .doc(userUSGId)
          .set(
        {
          ...userUSGModel.toJson(),
        },
      );
      return usgId;
    } catch (e) {
      log.e(e.toString());
      return null;
    }
  }

  Future<List<USGModel>> getUSGs(String clinicId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('usg')
          .get();
      List<USGModel> usgList = querySnapshot.docs
          .map((doc) => USGModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return usgList;
    } catch (e) {
      log.e('Error getting USGs: $e');
      return [];
    }
  }

  // Method to update the report URL
  Future<bool> updateReportUrl(
    String clinicId,
    String usgId,
    String userId,
    String userUsgId,
    String reportUrl,
  ) async {
    try {
      DocumentReference documentReference = _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('usg')
          .doc(usgId);

      DocumentReference userDocumentReference = _firestore
          .collection('users')
          .doc(userId)
          .collection('userUSG')
          .doc(userUsgId);

      await documentReference.update({'report': reportUrl});
      await userDocumentReference.update({'report': reportUrl});
      log.i('Report URL updated successfully');
      return true;
    } catch (e) {
      log.e('Failed to update report URL: $e');
      return false;
    }
  }

  Future<bool> updateReceiptUrl(String clinicId, String usgId, String userId,
      String userUsgId, String receiptUrl) async {
    try {
      DocumentReference documentReference = _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('usg')
          .doc(usgId);

      DocumentReference userDocumentReference = _firestore
          .collection('users')
          .doc(userId)
          .collection('userUSG')
          .doc(userUsgId);

      await documentReference.update({'receiptUrl': receiptUrl});
      await userDocumentReference.update({'receiptUrl': receiptUrl});
      log.i('Receipt URL updated successfully');
      return true;
    } catch (e) {
      log.e('Failed to update report URL: $e');
      return false;
    }
  }

  Future<List<UserUSGModel>> getUserUSGsByDate(
      String userId, DateTime date) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('usgs')
          .where('date', isEqualTo: date)
          .get();

      return snapshot.docs
          .map((doc) =>
              UserUSGModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log.e('Failed to fetch user USGs: $e');
      rethrow;
    }
  }
}
