import 'package:equatable/equatable.dart';

import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    super.id,
    super.slug,
    super.titleEn,
    super.titleAr,
    super.order,
    super.showInNavbar,
    super.createdAt,
    super.updatedAt,
    super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      titleEn: map['title_en'] != null ? map['title_en'] as String : null,
      titleAr: map['title_ar'] != null ? map['title_ar'] as String : null,
      order: map['order'] != null ? map['order'] as int : null,
      showInNavbar:
          map['show_in_navbar'] != null ? map['show_in_navbar'] as bool : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }
}
