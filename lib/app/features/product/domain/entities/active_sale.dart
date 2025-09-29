import 'package:equatable/equatable.dart';

class ActiveSale extends Equatable {
  final int? id;
  final int? productId;
  final String? discountType;
  final int? discountAmount;
  final String? startDate;
  final String? endDate;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;

  const ActiveSale({
    this.id,
    this.productId,
    this.discountType,
    this.discountAmount,
    this.startDate,
    this.endDate,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        discountType,
        discountAmount,
        startDate,
        endDate,
        active,
        createdAt,
        updatedAt,
      ];
}
