class MedicalPersonsModel {
  final String uid;
  final String personName;
  final String? degree;
  final String? designation;
  final String imageUrl;

  MedicalPersonsModel({
    required this.uid,
    required this.personName,
    this.degree,
    this.designation,
    required this.imageUrl,
  });

  factory MedicalPersonsModel.fromJson(Map<String, dynamic> json) {
    return MedicalPersonsModel(
      uid: json['uid'],
      personName: json['personName'],
      degree: json['degree'],
      designation: json['designation'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'personName': personName,
      'degree': degree,
      'designation': designation,
      'imageUrl': imageUrl,
    };
  }
}
