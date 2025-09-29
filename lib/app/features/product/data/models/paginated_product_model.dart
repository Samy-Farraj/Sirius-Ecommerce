import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/product/data/models/product_model.dart';

import '../../domain/entities/paginated_product.dart';
import '../../domain/entities/product.dart';

class PaginatedProductModel extends PaginatedProduct {
  PaginatedProductModel({
    super.currentPage,
    super.data,
    super.firstPageUrl,
    super.from,
    required super.lastPage,
    required super.perPage,
    super.to,
    super.total,
  });

  factory PaginatedProductModel.fromJson(Map<String, dynamic> map) {
    return PaginatedProductModel(
      currentPage:
          map['current_page'] != null ? map['current_page'] as int : null,
      data: map['data'] != null
          ? List<Product>.from(
              (map['data'] as List).map((e) => ProductModel.fromJson(e)))
          : null,
      firstPageUrl: map['first_page_url'] != null
          ? map['first_page_url'] as String
          : null,
      from: map['from'] != null ? map['from'] as int : null,
      lastPage: map['last_page'] != null ? map['last_page'] as int : 0,
      perPage: map['per_page'] != null ? map['per_page'] as int : 0,
      to: map['to'] != null ? map['to'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (currentPage != null) map['current_page'] = currentPage;

    if (firstPageUrl != null) map['first_page_url'] = firstPageUrl;
    if (from != null) map['from'] = from;
    map['last_page'] = lastPage;
    map['per_page'] = perPage;
    if (to != null) map['to'] = to;
    if (total != null) map['total'] = total;
    return map;
  }
}
