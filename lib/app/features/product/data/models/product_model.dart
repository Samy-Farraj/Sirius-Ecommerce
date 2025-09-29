import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/product/data/models/company_model.dart';
import 'package:sirius/app/features/product/data/models/product_image_model.dart';

import '../../../categories/data/models/category_model.dart';
import '../../domain/entities/BranchProducts.dart';
import '../../domain/entities/product.dart';
import 'active_sale_model.dart';

class ProductModel extends Product {
  const ProductModel({
    super.id,
    super.companyId,
    super.name,
    super.description,
    super.images,
    super.gender,
    super.isOnSale,
    super.isReplaceable,
    super.activeSale,
    super.isRefundable,
    super.points,
    super.tags,
    super.createdAt,
    super.updatedAt,
    super.company,
    super.categories,
    super.branchProducts,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : null,
      companyId: map['company_id'] != null ? map['company_id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      images: map['images'] != null
          ? (map['images'] as List)
              .map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      isOnSale: map['is_on_sale'] != null ? map['is_on_sale'] as bool : null,
      isReplaceable:
          map['is_replaceable'] != null ? map['is_replaceable'] as bool : null,
      isRefundable:
          map['is_refundable'] != null ? map['is_refundable'] as bool : null,
      points: map['points'] != null ? map['points'] as int : null,
      tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      company: map['company'] != null
          ? CompanyModel.fromJson(map['company'] as Map<String, dynamic>)
          : null,
      activeSale: map['active_sale'] != null
          ? ActiveSaleModel.fromJson(map['active_sale'] as Map<String, dynamic>)
          : null,
      categories: map['categories'] != null
          ? (map['categories'] as List)
              .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      branchProducts: map['branch_products'] != null
          ? (map['branch_products'] as List)
              .map((e) =>
                  BranchProductsModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (companyId != null) data['company_id'] = companyId;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((e) => e.toJson()).toList();
    }
    if (gender != null) data['gender'] = gender;
    if (isOnSale != null) data['is_on_sale'] = isOnSale;
    if (isReplaceable != null) data['is_replaceable'] = isReplaceable;
    if (isRefundable != null) data['is_refundable'] = isRefundable;
    if (points != null) data['points'] = points;
    if (tags != null) data['tags'] = tags;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (company != null) data['company'] = company!.toJson();
    // if (categories != null) {
    //   data['categories'] = categories!.map((e) => e.toJson()).toList();
    // }
    if (branchProducts != null) data['branch_products'] = branchProducts;
    return data;
  }
}
