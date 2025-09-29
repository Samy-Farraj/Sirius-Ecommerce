import 'package:equatable/equatable.dart';

import '../../domain/entities/pivot.dart';

class PivotModel extends Pivot {
  const PivotModel({
    super.productId,
    super.categoryId,
    super.createdAt,
    super.updatedAt,
  });

  factory PivotModel.fromJson(Map<String, dynamic> map) {
    return PivotModel(
      productId: map['product_id'] != null ? map['product_id'] as int : null,
      categoryId: map['category_id'] != null ? map['category_id'] as int : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (productId != null) data['product_id'] = productId;
    if (categoryId != null) data['category_id'] = categoryId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    return data;
  }
}
