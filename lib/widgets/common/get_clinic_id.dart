import 'dart:math';

String createClinicID() {
  const int length = 6;
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  Random random = Random();
  String clinicID = '';

  for (int i = 0; i < length; i++) {
    clinicID += chars[random.nextInt(chars.length)];
  }

  return clinicID;
}
