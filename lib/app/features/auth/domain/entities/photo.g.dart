// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      createdBy: json['createdBy'] as String?,
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      lastModifiedBy: json['lastModifiedBy'] as String?,
      id: json['id'] as String?,
      imageId: json['imageId'] as String?,
      name: json['name'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      appUserId: json['appUserId'] as String?,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'created': instance.created?.toIso8601String(),
      'createdBy': instance.createdBy,
      'lastModified': instance.lastModified?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'id': instance.id,
      'imageId': instance.imageId,
      'name': instance.name,
      'isDeleted': instance.isDeleted,
      'appUserId': instance.appUserId,
    };
