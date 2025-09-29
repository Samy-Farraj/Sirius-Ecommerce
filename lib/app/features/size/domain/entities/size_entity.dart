import 'package:equatable/equatable.dart';

class SizeEntity extends Equatable {
  final int? id;
  final String? name;
  final int? categoryId;
  final String? additionalInfo;
  final String? createdAt;
  final String? updatedAt;

  const SizeEntity({
    this.id,
    this.name,
    this.categoryId,
    this.additionalInfo,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        categoryId,
        additionalInfo,
        createdAt,
        updatedAt,
      ];
}
