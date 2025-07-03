import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/photo.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends AppUser {
  const UserModel(
      {required super.id,
      required super.email,
      required super.userType,
      required super.birthDate,
      required super.gender,
      required super.notificationToken,
      required super.macAddress,
      required super.profilePhoto,
      required super.lang,
      required super.isDriver,
      required super.lastName,
      required super.firstName,
      required super.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
