import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ultrasound_clinic/models/common/appointment_model.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class AppointmentsService {
  AppointmentsService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final AppointmentsService _instance =
      AppointmentsService._privateConstructor();

  // Factory constructor to return the static instance
  factory AppointmentsService() {
    return _instance;
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createAppointment(
    String clinicId,
    String userId,
    AppointmentInputModel appointment,
  ) async {
    try {
      String appointmentId = _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('appointments')
          .doc()
          .id;
      String userAppointmentId = _firestore
          .collection('users')
          .doc(userId)
          .collection('userAppointments')
          .doc()
          .id;
      await _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('appointments')
          .doc(appointmentId)
          .set(
        {
          ...appointment.toJson(),
          'uid': appointmentId,
          'userId': userId,
        },
      );
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('userAppointments')
          .doc(userAppointmentId)
          .set(
        {
          ...appointment.toJson(),
          'uid': userAppointmentId,
          'refId': appointmentId,
        },
      );

      return appointmentId;
    } catch (e) {
      log.e('Error creating appointment: $e');
      return null;
    }
  }
}
