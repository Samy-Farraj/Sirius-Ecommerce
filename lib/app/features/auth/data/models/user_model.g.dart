// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      userType: json['userType'] as String?,
      birthDate: json['birthDate'],
      gender: json['gender'] as String?,
      notificationToken: json['notificationToken'] as String?,
      macAddress: json['macAddress'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      lang: json['lang'] as String?,
      isDriver: json['isDriver'] as bool?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'birthDate': instance.birthDate,
      'lang': instance.lang,
      'macAddress': instance.macAddress,
      'phone': instance.phone,
      'userType': instance.userType,
      'profilePhoto': instance.profilePhoto,
      'notificationToken': instance.notificationToken,
      'gender': instance.gender,
      'isDriver': instance.isDriver,
    };
