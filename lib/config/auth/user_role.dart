import 'package:ultrasound_clinic/constants/enums/role_enum.dart';
import 'package:ultrasound_clinic/models/auth/role_model.dart';
import 'package:ultrasound_clinic/resources/strings.dart';

final List<RoleModel> userRoles = [
  RoleModel(
    roleId: 1,
    roleName: Strings.patient,
    roleConstant: UserRoleEnum.patient.roleName,
  ),
  RoleModel(
    roleId: 2,
    roleName: Strings.clinic,
    roleConstant: UserRoleEnum.clinic.roleName,
  ),
];
