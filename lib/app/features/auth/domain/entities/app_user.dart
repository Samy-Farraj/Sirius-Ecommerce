import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'photo.dart';

part 'app_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppUser extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic birthDate;
  final String? lang;
  final String? macAddress;
  final String? phone;
  final String? userType;
  final String? profilePhoto;
  final String? notificationToken;
  final String? gender;
  final bool? isDriver;

  const AppUser({
    this.id,
    this.isDriver,
    this.birthDate,
    this.notificationToken,
    this.macAddress,
    this.gender,
    this.profilePhoto,
    this.lang,
    this.lastName,
    this.firstName,
    this.email,
    this.phone,
    this.userType,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  List<Object?> get props => [
        id,
        firstName,
        isDriver,
        lastName,
        email,
        birthDate,
        lang,
        macAddress,
        phone,
        userType,
        profilePhoto,
        notificationToken,
        gender,
      ];
}
