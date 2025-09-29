import 'package:equatable/equatable.dart';

import '../../domain/entities/sub_category.dart';
import 'image_model.dart';

class SubCategoryModel extends SubCategory {
  SubCategoryModel({
    super.id,
    super.slug,
    super.titleEn,
    super.titleAr,
    super.description,
    super.order,
    super.showInNavbar,
    super.createdAt,
    super.updatedAt,

  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      titleEn: map['title_en'] != null ? map['title_en'] as String : null,
      titleAr: map['title_ar'] != null ? map['title_ar'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      order: map['order'],
      showInNavbar: map['show_in_navbar'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,

    );
  }
}
