import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/color/data/models/my_color_model.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/product/data/models/PriceRangeFilterModel.dart';
import 'package:sirius/app/features/product/data/models/company_model.dart';
import 'package:sirius/app/features/size/data/models/size_entity_model.dart';

import '../../../product/data/models/SubCategoryFilterModel.dart';
import '../../domain/entities/FilterEntity.dart';

class FilterEntityModel extends FilterEntity {
  FilterEntityModel({
    super.genders,
    super.colors,
    super.sizes,
    super.companies,
    super.subCategories,
    super.priceRange,
  });

  factory FilterEntityModel.fromJson(Map<String, dynamic> map) {
    return FilterEntityModel(
      genders: map['genders'] != null
          ? List<String>.from(map['genders'] as List)
          : null,
      colors: map['colors'] != null
          ? (map['colors'] as List)
              .map((e) => MyColorModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      sizes: map['sizes'] != null
          ? (map['sizes'] as List)
              .map((e) => SizeEntityModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      companies: map['companies'] != null
          ? (map['companies'] as List)
              .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      subCategories: map['sub_categories'] != null
          ? (map['sub_categories'] as List)
              .map((e) =>
                  SubCategoryFilterModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      priceRange: map['price_range'] != null
          ? PriceRangeFilterModel.fromJson(
              map['price_range'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (genders != null) {
      map['genders'] = genders;
    }

    if (priceRange != null) {
      map['price_range'] = priceRange!.toJson();
    }

    return map;
  }
}
