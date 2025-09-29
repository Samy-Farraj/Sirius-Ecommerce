import 'package:equatable/equatable.dart';

import '../../domain/entities/active_sale.dart';

class ActiveSaleModel extends ActiveSale {
  const ActiveSaleModel({
    super.id,
    super.productId,
    super.discountType,
    super.discountAmount,
    super.startDate,
    super.endDate,
    super.active,
    super.createdAt,
    super.updatedAt,
  });

  factory ActiveSaleModel.fromJson(Map<String, dynamic> map) {
    return ActiveSaleModel(
      id: map['id'] != null ? map['id'] as int : null,
      productId: map['product_id'] != null ? map['product_id'] as int : null,
      discountType:
          map['discount_type'] != null ? map['discount_type'] as String : null,
      discountAmount:
          map['discount_amount'] != null ? map['discount_amount'] as int : null,
      startDate: map['start_date'] != null ? map['start_date'] as String : null,
      endDate: map['end_date'] != null ? map['end_date'] as String : null,
      active: map['active'] != null ? map['active'] as bool : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (id != null) map['id'] = id;
    if (productId != null) map['product_id'] = productId;
    if (discountType != null) map['discount_type'] = discountType;
    if (discountAmount != null) map['discount_amount'] = discountAmount;
    if (startDate != null) map['start_date'] = startDate;
    if (endDate != null) map['end_date'] = endDate;
    if (active != null) map['active'] = active;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;

    return map;
  }
}
