import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String uid;
  String patientName;
  String mobileNumber;
  DateTime date;
  DateTime requestDate;
  String userId;
  String appointmentRefId;

  AppointmentModel({
    required this.uid,
    required this.patientName,
    required this.mobileNumber,
    required this.date,
    required this.requestDate,
    required this.userId,
    required this.appointmentRefId,
  });

  // Method to convert a JSON map to an AppointmentInputModel instance
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientName: json['patientName'],
      mobileNumber: json['mobileNumber'],
      date: json['date'] as DateTime,
      requestDate: json['requestDate'] as DateTime,
      uid: json['uid'],
      userId: json['userId'],
      appointmentRefId: json['appointmentRefId'],
    );
  }

  // Method to convert a JSON map to an AppointmentInputModel instance
  factory AppointmentModel.fromTJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientName: json['patientName'],
      mobileNumber: json['mobileNumber'],
      date: (json['date'] as Timestamp).toDate().toLocal(),
      requestDate: (json['requestDate'] as Timestamp).toDate().toLocal(),
      uid: json['uid'],
      userId: json['userId'],
      appointmentRefId: json['appointmentRefId'],
    );
  }

  // Method to convert an AppointmentInputModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'mobileNumber': mobileNumber,
      'date': date,
      'requestDate': requestDate,
      'uid': uid,
      'userId': userId,
      'appointmentRefId': appointmentRefId,
    };
  }
}

class UserAppointmentModel {
  String uid;
  String patientName;
  String mobileNumber;
  DateTime date;
  DateTime requestDate;
  String refId;
  String clinicId;

  UserAppointmentModel({
    required this.uid,
    required this.patientName,
    required this.mobileNumber,
    required this.date,
    required this.requestDate,
    required this.refId,
    required this.clinicId,
  });

  // Method to convert a JSON map to an UserAppointmentModel instance
  factory UserAppointmentModel.fromJson(Map<String, dynamic> json) {
    return UserAppointmentModel(
      patientName: json['patientName'],
      mobileNumber: json['mobileNumber'],
      date: json['date'],
      requestDate: json['requestDate'],
      uid: json['uid'],
      refId: json['refId'],
      clinicId: json['clinicId'],
    );
  }

  // Method to convert an UserAppointmentModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'mobileNumber': mobileNumber,
      'date': date,
      'requestDate': requestDate,
      'uid': uid,
      'refId': refId,
      'clinicId': clinicId,
    };
  }
}
