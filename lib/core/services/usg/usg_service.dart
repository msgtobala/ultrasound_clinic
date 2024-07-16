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
      String fileName = generateFileName(usg['prescription'].path);
      final prescriptionURL = await _firebaseStorage.uploadFile(
        usg['prescription'],
        'users/$userId/prescriptions',
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
      });
      UserUSGModel userUSGModel = UserUSGModel.fromJson({
        ...usg,
        'uid': userUSGId,
        'prescription': prescriptionURL,
        'refId': usgId,
        'clinicId': clinicId,
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
      log.e('Error creating USG: $e');
      return null;
    }
  }
}
