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
    Map<String, dynamic> appointment,
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

      AppointmentModel appointmentModel = AppointmentModel.fromJson({
        ...appointment,
        'uid': appointmentId,
        'userId': userId,
        'appointmentRefId': userAppointmentId,
      });
      UserAppointmentModel userAppointmentModel =
          UserAppointmentModel.fromJson({
        ...appointment,
        'uid': userAppointmentId,
        'refId': appointmentId,
        'clinicId': clinicId,
      });

      await _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('appointments')
          .doc(appointmentId)
          .set(
        {
          ...appointmentModel.toJson(),
        },
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('userAppointments')
          .doc(userAppointmentId)
          .set(
        {
          ...userAppointmentModel.toJson(),
        },
      );

      return appointmentId;
    } catch (e) {
      log.e('Error creating appointment: $e');
      return null;
    }
  }

  // Method to get today's clinic appointments
  Future<List<AppointmentModel>> getTodaysClinicAppointments(
      String clinicId) async {
    try {
      DateTime now = DateTime.now();
      DateTime todayStart = DateTime(now.year, now.month, now.day);
      DateTime todayEnd = DateTime(now.year, now.month, now.day + 1);

      Timestamp startTimestamp = Timestamp.fromDate(todayStart);
      Timestamp endTimestamp = Timestamp.fromDate(todayEnd);

      QuerySnapshot querySnapshot = await _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('appointments')
          .where('date', isGreaterThanOrEqualTo: startTimestamp)
          .where('date', isLessThan: endTimestamp)
          .get();
      List<AppointmentModel> appointments = querySnapshot.docs
          .map((doc) =>
              AppointmentModel.fromTJson(doc.data() as Map<String, dynamic>))
          .toList();

      return appointments;
    } catch (e) {
      log.e('Error fetching today\'s clinic appointments: $e');
      return [];
    }
  }

  // Method to get upcoming clinic appointments
  Future<List<AppointmentModel>> getUpcomingAppointments(
      String clinicId) async {
    try {
      DateTime now = DateTime.now();
      Timestamp startTimestamp = Timestamp.fromDate(now);

      QuerySnapshot querySnapshot = await _firestore
          .collection('clinics')
          .doc(clinicId)
          .collection('appointments')
          .where('date', isGreaterThanOrEqualTo: startTimestamp)
          .orderBy('date')
          .get();

      List<AppointmentModel> appointments = querySnapshot.docs
          .map((doc) =>
              AppointmentModel.fromTJson(doc.data() as Map<String, dynamic>))
          .toList();

      return appointments;
    } catch (e) {
      log.e('Error fetching upcoming clinic appointments: $e');
      return [];
    }
  }

  Future<List<AppointmentModel>> getUserAppointmentsByDate(
    String userId,
    DateTime date,
  ) async {
    try {
      DateTime startOfDay = DateTime(date.year, date.month, date.day);
      DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      Timestamp startTimestamp = Timestamp.fromDate(startOfDay);
      Timestamp endTimestamp = Timestamp.fromDate(endOfDay);

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('userAppointments')
          .where('date', isGreaterThanOrEqualTo: startTimestamp)
          .where('date', isLessThanOrEqualTo: endTimestamp)
          .get();

      List<AppointmentModel> appointments = querySnapshot.docs
          .map((doc) =>
              AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return appointments;
    } catch (e) {
      log.e('Error fetching user appointments by date: $e');
      return [];
    }
  }
}
