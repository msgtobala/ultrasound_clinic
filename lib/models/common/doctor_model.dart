class DoctorModel {
  final String uid;
  final String doctorName;
  final String phoneNumber;
  final String degree;
  final String description;
  final String imageUrl;

  DoctorModel({
    required this.uid,
    required this.doctorName,
    required this.phoneNumber,
    required this.degree,
    required this.description,
    required this.imageUrl,
  });

  // Convert a Doctor object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'doctorName': doctorName,
      'phoneNumber': phoneNumber,
      'degree': degree,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Create a Doctor object from a JSON map
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      uid: json['uid'] as String,
      doctorName: json['doctorName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      degree: json['degree'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
