import 'package:json_annotation/json_annotation.dart';
import 'package:sirius/app/features/auth/data/models/user_model.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_user.dart';

part 'auth_user_model.g.dart';

@JsonSerializable()
class AuthUserModel extends AuthUser {
  const AuthUserModel(
    super.company,
    super.token,
  );

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
}
