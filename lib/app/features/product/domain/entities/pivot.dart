import 'package:equatable/equatable.dart';

class Pivot extends Equatable {
  final int? productId;
  final int? categoryId;
  final String? createdAt;
  final String? updatedAt;

  const Pivot({
    this.productId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [productId, categoryId, createdAt, updatedAt];
}
