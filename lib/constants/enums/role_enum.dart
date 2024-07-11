enum UserRoleEnum { patient, clinic }

extension UserRoleEnumExtension on UserRoleEnum {
  String get roleName {
    switch (this) {
      case UserRoleEnum.patient:
        return 'patient';
      case UserRoleEnum.clinic:
        return 'clinic';
      default:
        return '';
    }
  }
}
