class USGModel {
  String uid;
  String patientName;
  String mobileNumber;
  String prescription;
  String report;
  String address;
  String state;
  String city;
  String pinCode;
  String usgRefId;

  USGModel({
    required this.uid,
    required this.patientName,
    required this.mobileNumber,
    required this.prescription,
    required this.address,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.report,
    required this.usgRefId,
  });

  // Factory constructor to create an instance from a JSON map
  factory USGModel.fromJson(Map<String, dynamic> json) {
    return USGModel(
      uid: json['uid'] as String,
      patientName: json['patientName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      prescription: json['prescription'] as String,
      address: json['address'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      pinCode: json['pinCode'] as String,
      report: json['report'] as String,
      usgRefId: json['usgRefId'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'patientName': patientName,
      'mobileNumber': mobileNumber,
      'prescription': prescription,
      'address': address,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'report': report,
      'usgRefId': usgRefId,
    };
  }
}

class UserUSGModel {
  String uid;
  String patientName;
  String mobileNumber;
  String prescription;
  String report;
  String address;
  String state;
  String city;
  String pinCode;
  String refId;
  String clinicId;

  UserUSGModel({
    required this.uid,
    required this.patientName,
    required this.mobileNumber,
    required this.prescription,
    required this.address,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.report,
    required this.refId,
    required this.clinicId,
  });

  // Factory constructor to create an instance from a JSON map
  factory UserUSGModel.fromJson(Map<String, dynamic> json) {
    return UserUSGModel(
      uid: json['uid'] as String,
      patientName: json['patientName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      prescription: json['prescription'] as String,
      address: json['address'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      pinCode: json['pinCode'] as String,
      report: json['report'] as String,
      refId: json['refId'] as String,
      clinicId: json['clinicId'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'patientName': patientName,
      'mobileNumber': mobileNumber,
      'prescription': prescription,
      'address': address,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'report': report,
      'refId': refId,
      'clinicId': clinicId,
    };
  }
}
