import '../../domain/entities/product_sale.dart';

class ProductSaleModel extends ProductSale {
  ProductSaleModel({
    super.id,
    super.purchaseCount,
    super.purchaseValue,
    super.title,
    super.firstImage,
  });

  factory ProductSaleModel.fromJson(Map<String, dynamic> map) {
    return ProductSaleModel(
      id: map['id'] != null ? map['id'] as int : null,
      purchaseCount:
          map['purchase_count'] != null ? map['purchase_count'] as int : null,
      purchaseValue:
          map['purchase_value'] != null ? map['purchase_value'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      firstImage:
          map['first_image'] != null ? map['first_image'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (purchaseCount != null) data['purchase_count'] = purchaseCount;
    if (purchaseValue != null) data['purchase_value'] = purchaseValue;
    if (title != null) data['title'] = title;
    if (firstImage != null) data['first_image'] = firstImage;
    return data;
  }
}
