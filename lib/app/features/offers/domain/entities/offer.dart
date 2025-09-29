import 'package:equatable/equatable.dart';

import '../../../product/data/models/product_model.dart';

enum DiscountType { percentage, fixed }

class Offer extends Equatable {
  final int? id;
  final int? productId;
  final DiscountType? discountType;
  final num? discountAmount;
  final String? startDate;
  final String? endDate;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;
  final ProductModel? product;

  const Offer({
    this.id,
    this.productId,
    this.discountType,
    this.discountAmount,
    this.startDate,
    this.endDate,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.product,
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
        product,
      ];
}
