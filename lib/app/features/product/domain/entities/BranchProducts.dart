import 'package:equatable/equatable.dart';

class BranchProducts extends Equatable {
  final int? id;
  final int? companyId;
  final int? branchId;
  final int? productId;
  final double? price;
  final String? createdAt;
  final String? updatedAt;
  final Branch? branch;
  final List<ProductStorage>? productStorage;

  const BranchProducts({
    this.id,
    this.companyId,
    this.branchId,
    this.productId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.productStorage,
  });

  @override
  List<Object?> get props => [
        id,
        companyId,
        branchId,
        productId,
        price,
        createdAt,
        updatedAt,
        branch,
        productStorage,
      ];
}

class BranchProductsModel extends BranchProducts {
  const BranchProductsModel({
    super.id,
    super.companyId,
    super.branchId,
    super.productId,
    super.price,
    super.createdAt,
    super.updatedAt,
    super.branch,
    super.productStorage,
  });

  factory BranchProductsModel.fromJson(Map<String, dynamic> map) {
    return BranchProductsModel(
      id: map['id'] != null ? map['id'] as int : null,
      companyId: map['company_id'] != null ? map['company_id'] as int : null,
      branchId: map['branch_id'] != null ? map['branch_id'] as int : null,
      productId: map['product_id'] != null ? map['product_id'] as int : null,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      branch:
          map['branch'] != null ? BranchModel.fromJson(map['branch']) : null,
      productStorage: map['product_storage'] != null
          ? List<ProductStorageModel>.from(
              (map['product_storage'] as List<dynamic>)
                  .map((e) => ProductStorageModel.fromJson(e)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (id != null) map['id'] = id;
    if (companyId != null) map['company_id'] = companyId;
    if (branchId != null) map['branch_id'] = branchId;
    if (productId != null) map['product_id'] = productId;
    if (price != null) map['price'] = price;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;
    if (branch != null) map['branch'] = (branch as BranchModel).toJson();
    if (productStorage != null) {
      map['product_storage'] = productStorage!
          .map((e) => (e as ProductStorageModel).toJson())
          .toList();
    }

    return map;
  }
}

class Branch extends Equatable {
  final int? id;
  final int? companyId;
  final int? cityId;
  final String? address;
  final String? longitude;
  final String? latitude;
  final String? title;
  final String? createdAt;
  final String? updatedAt;

  const Branch({
    this.id,
    this.companyId,
    this.cityId,
    this.address,
    this.longitude,
    this.latitude,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        companyId,
        cityId,
        address,
        longitude,
        latitude,
        title,
        createdAt,
        updatedAt
      ];
}

class BranchModel extends Branch {
  const BranchModel({
    super.id,
    super.companyId,
    super.cityId,
    super.address,
    super.longitude,
    super.latitude,
    super.title,
    super.createdAt,
    super.updatedAt,
  });

  factory BranchModel.fromJson(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'] != null ? map['id'] as int : null,
      companyId: map['company_id'] != null ? map['company_id'] as int : null,
      cityId: map['city_id'] != null ? map['city_id'] as int : null,
      address: map['address'] != null ? map['address'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (companyId != null) map['company_id'] = companyId;
    if (cityId != null) map['city_id'] = cityId;
    if (address != null) map['address'] = address;
    if (longitude != null) map['longitude'] = longitude;
    if (latitude != null) map['latitude'] = latitude;
    if (title != null) map['title'] = title;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;
    return map;
  }
}

class ProductStorage extends Equatable {
  final int? id;
  final int? branchProductId;
  final int? sizeId;
  final int? colorId;
  final int? quantity;
  final String? createdAt;
  final String? updatedAt;
  final Color? color;
  final Size? size;

  const ProductStorage({
    this.id,
    this.branchProductId,
    this.sizeId,
    this.colorId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.size,
  });

  @override
  List<Object?> get props => [
        id,
        branchProductId,
        sizeId,
        colorId,
        quantity,
        createdAt,
        updatedAt,
        color,
        size
      ];
}

class ProductStorageModel extends ProductStorage {
  const ProductStorageModel({
    super.id,
    super.branchProductId,
    super.sizeId,
    super.colorId,
    super.quantity,
    super.createdAt,
    super.updatedAt,
    super.color,
    super.size,
  });

  factory ProductStorageModel.fromJson(Map<String, dynamic> map) {
    return ProductStorageModel(
      id: map['id'] != null ? map['id'] as int : null,
      branchProductId: map['branch_product_id'] != null
          ? map['branch_product_id'] as int
          : null,
      sizeId: map['size_id'] != null ? map['size_id'] as int : null,
      colorId: map['color_id'] != null ? map['color_id'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      color: map['color'] != null ? ColorModel.fromJson(map['color']) : null,
      size: map['size'] != null ? SizeModel.fromJson(map['size']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (branchProductId != null) map['branch_product_id'] = branchProductId;
    if (sizeId != null) map['size_id'] = sizeId;
    if (colorId != null) map['color_id'] = colorId;
    if (quantity != null) map['quantity'] = quantity;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;
    if (color != null) map['color'] = (color as ColorModel).toJson();
    if (size != null) map['size'] = (size as SizeModel).toJson();
    return map;
  }
}

class Color extends Equatable {
  final int? id;
  final int? combinedWith;
  final String? name;
  final String? hashCodeColor;
  final String? createdAt;
  final String? updatedAt;

  const Color({
    this.id,
    this.combinedWith,
    this.name,
    this.hashCodeColor,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, combinedWith, name, hashCodeColor, createdAt, updatedAt];
}

class ColorModel extends Color {
  const ColorModel({
    super.id,
    super.combinedWith,
    super.name,
    super.hashCodeColor,
    super.createdAt,
    super.updatedAt,
  });

  factory ColorModel.fromJson(Map<String, dynamic> map) {
    return ColorModel(
      id: map['id'] != null ? map['id'] as int : null,
      combinedWith:
          map['combined_with'] != null ? map['combined_with'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      hashCodeColor:
          map['hash_code'] != null ? map['hash_code'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (combinedWith != null) map['combined_with'] = combinedWith;
    if (name != null) map['name'] = name;
    if (hashCode != null) map['hash_code'] = hashCode;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;
    return map;
  }
}

class Size extends Equatable {
  final int? id;
  final String? name;
  final int? categoryId;
  final String? additionalInfo;
  final String? createdAt;
  final String? updatedAt;

  const Size({
    this.id,
    this.name,
    this.categoryId,
    this.additionalInfo,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, name, categoryId, additionalInfo, createdAt, updatedAt];
}

class SizeModel extends Size {
  const SizeModel({
    super.id,
    super.name,
    super.categoryId,
    super.additionalInfo,
    super.createdAt,
    super.updatedAt,
  });

  factory SizeModel.fromJson(Map<String, dynamic> map) {
    return SizeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      categoryId: map['category_id'] != null ? map['category_id'] as int : null,
      additionalInfo: map['additional_info'] != null
          ? map['additional_info'] as String
          : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (name != null) map['name'] = name;
    if (categoryId != null) map['category_id'] = categoryId;
    if (additionalInfo != null) map['additional_info'] = additionalInfo;
    if (createdAt != null) map['created_at'] = createdAt;
    if (updatedAt != null) map['updated_at'] = updatedAt;
    return map;
  }
}
