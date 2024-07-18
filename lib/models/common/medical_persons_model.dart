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
}
