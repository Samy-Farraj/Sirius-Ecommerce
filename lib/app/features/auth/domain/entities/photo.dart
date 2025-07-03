import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo extends Equatable {
  final DateTime? created;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final String? id;
  final String? imageId;
  final String? name;
  final bool? isDeleted;
  final String? appUserId;

  const Photo({
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.id,
    required this.imageId,
    required this.name,
    required this.isDeleted,
    required this.appUserId,
  });

  @override
  List<Object?> get props => [
        created,
        createdBy,
        lastModified,
        lastModifiedBy,
        id,
        imageId,
        name,
        isDeleted,
        appUserId,
      ];

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
