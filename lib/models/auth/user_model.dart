class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String phone;
  final List<String> clinics;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.clinics,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      phone: data['phone'] ?? '',
      clinics: List<String>.from(data['clinics'] ?? []),
    );
  }

  factory UserModel.empty() {
    return UserModel(
      uid: '',
      name: '',
      email: '',
      role: '',
      phone: '',
      clinics: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'clinics': clinics,
    };
  }
}
