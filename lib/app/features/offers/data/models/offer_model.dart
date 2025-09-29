import 'package:equatable/equatable.dart';

import '../../../product/data/models/product_model.dart';
import '../../domain/entities/offer.dart';

class OfferModel extends Offer {
  const OfferModel({
    super.id,
    super.productId,
    super.discountType,
    super.discountAmount,
    super.startDate,
    super.endDate,
    super.active,
    super.createdAt,
    super.updatedAt,
    super.product,
  });

  factory OfferModel.fromJson(Map<String, dynamic> map) {
    return OfferModel(
      id: map['id'] != null ? map['id'] as int : null,
      productId: map['product_id'] != null ? map['product_id'] as int : null,
      discountType: map['discount_type'] != null
          ? _discountTypeFromString(map['discount_type'] as String)
          : null,
      discountAmount:
          map['discount_amount'] != null ? map['discount_amount'] as num : null,
      startDate: map['start_date'] != null ? map['start_date'] as String : null,
      endDate: map['end_date'] != null ? map['end_date'] as String : null,
      active: map['active'] != null ? map['active'] as bool : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      product: map['product'] != null
          ? ProductModel.fromJson(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (productId != null) map['product_id'] = productId;
    if (discountType != null) {
      map['discount_type'] = _discountTypeToString(discountType!);
    }
    if (discountAmount != null) map['discount_amount'] = discountAmount;
    if (startDate != null) map['start_date'] = startDate;
    if (endDate != null) map['end_date'] = endDate;
    if (active != null) map['active'] = active;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;
    if (product != null) map['product'] = (product as ProductModel).toJson();
    return map;
  }

  static DiscountType _discountTypeFromString(String value) {
    switch (value) {
      case 'percentage':
        return DiscountType.percentage;
      case 'fixed':
        return DiscountType.fixed;
      default:
        throw Exception('Invalid discount type: $value');
    }
  }

  static String _discountTypeToString(DiscountType type) {
    switch (type) {
      case DiscountType.percentage:
        return 'percentage';
      case DiscountType.fixed:
        return 'fixed';
    }
  }
}
