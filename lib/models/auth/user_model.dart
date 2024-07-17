class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String phone;
  final List<String> clinics;
  final String? address;
  final String? city;
  final String? profileUrl;
  final String? state;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.clinics,
    this.profileUrl,
    this.address,
    this.state,
    this.city,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      profileUrl: data['profileUrl'] ?? '',
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
      city: '',
      state: '',
      address: '',
      profileUrl: '',
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
      'address': address,
      'city': city,
      'state': state,
      'profileUrl': profileUrl,
    };
  }
}
