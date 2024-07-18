class StaffModel {
  final String uid;
  final String staffName;
  final String phoneNumber;
  final String designation;
  final String imageUrl;

  StaffModel({
    required this.uid,
    required this.staffName,
    required this.phoneNumber,
    required this.designation,
    required this.imageUrl,
  });

  // Convert a Doctor object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'staffName': staffName,
      'phoneNumber': phoneNumber,
      'designation': designation,
      'imageUrl': imageUrl,
    };
  }

  // Create a Doctor object from a JSON map
  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      uid: json['uid'] as String,
      staffName: json['staffName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      designation: json['designation'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
