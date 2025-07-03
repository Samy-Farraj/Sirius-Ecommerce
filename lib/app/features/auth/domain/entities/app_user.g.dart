// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: (json['id'] as num?)?.toInt(),
      isDriver: json['is_driver'] as bool?,
      birthDate: json['birth_date'],
      notificationToken: json['notification_token'] as String?,
      macAddress: json['mac_address'] as String?,
      gender: json['gender'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      lang: json['lang'] as String?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'birth_date': instance.birthDate,
      'lang': instance.lang,
      'mac_address': instance.macAddress,
      'phone': instance.phone,
      'user_type': instance.userType,
      'profile_photo': instance.profilePhoto,
      'notification_token': instance.notificationToken,
      'gender': instance.gender,
      'is_driver': instance.isDriver,
    };
