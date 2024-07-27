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
  String userId;
  String receiptUrl;

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
    required this.userId,
    required this.receiptUrl,
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
        userId: json['userId'] as String,
        receiptUrl: json['receiptUrl'] as String);
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
      'userId': userId,
      'receiptUrl': receiptUrl,
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
  String receiptUrl;

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
    required this.receiptUrl,
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
      receiptUrl: json['receiptUrl'] as String,
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
      'receiptUrl': receiptUrl,
    };
  }
}
