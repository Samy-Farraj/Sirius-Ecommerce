import 'package:equatable/equatable.dart';

import '../../../categories/data/models/category_model.dart';
import '../../../categories/domain/entities/category.dart';
import '../../data/models/company_model.dart';
import '../../data/models/product_image_model.dart';
import 'BranchProducts.dart';
import 'active_sale.dart';

class Product extends Equatable {
  final int? id;
  final int? companyId;
  final String? name;
  final String? description;
  final List<ProductImageModel>? images;
  final String? gender;
  final bool? isOnSale;
  final bool? isReplaceable;
  final bool? isRefundable;
  final int? points;
  final List<String>? tags;
  final String? createdAt;
  final String? updatedAt;
  final CompanyModel? company;
  final ActiveSale? activeSale;
  final List<Category>? categories;
  final List<BranchProducts>? branchProducts;

  const Product({
    this.id,
    this.activeSale,
    this.companyId,
    this.name,
    this.description,
    this.images,
    this.gender,
    this.isOnSale,
    this.isReplaceable,
    this.isRefundable,
    this.points,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.categories,
    this.branchProducts,
  });

  @override
  List<Object?> get props => [
        id,
        companyId,
        name,
        description,
        images,
        gender,
        isOnSale,
        isReplaceable,
        isRefundable,
        activeSale,
        points,
        tags,
        createdAt,
        updatedAt,
        company,
        categories,
        branchProducts,
      ];
}
