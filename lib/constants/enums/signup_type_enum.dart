enum SignupTypeEnum {
  email,
  phone,
}

extension SignupTypeEnumExtension on SignupTypeEnum {
  String get value {
    switch (this) {
      case SignupTypeEnum.email:
        return 'email';
      case SignupTypeEnum.phone:
        return 'phone';
      default:
        return 'email';
    }
  }
}
