class AppointmentInputModel {
  String patientName;
  String mobileNumber;
  String date;
  String time;
  String requestDate;

  AppointmentInputModel({
    required this.patientName,
    required this.mobileNumber,
    required this.date,
    required this.time,
    required this.requestDate,
  });

  // Method to convert a JSON map to an AppointmentInputModel instance
  factory AppointmentInputModel.fromJson(Map<String, dynamic> json) {
    return AppointmentInputModel(
      patientName: json['patientName'],
      mobileNumber: json['mobileNumber'],
      date: json['date'],
      time: json['time'],
      requestDate: DateTime.now().toString(),
    );
  }

  // Method to convert an AppointmentInputModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'mobileNumber': mobileNumber,
      'date': date,
      'time': time,
      'requestDate': requestDate,
    };
  }
}
