import 'package:equatable/equatable.dart';

import '../../../product/data/models/pivot_model.dart';
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    super.id,
    super.image,
    super.parentCategoryId,
    super.name,
    super.pivot,
    super.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      image: map['image'] != null ? map['image'] as String : null,
      parentCategoryId: map['parent_category_id'] != null
          ? map['parent_category_id'] as int
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      children: map['children'] != null
          ? List<CategoryModel>.from(
              (map['children'] as List).map(
                (child) =>
                    CategoryModel.fromJson(child as Map<String, dynamic>),
              ),
            )
          : null,
      pivot: map['pivot'] != null
          ? PivotModel.fromJson(map['pivot'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (image != null) data['image'] = image;
    if (parentCategoryId != null) data['parent_category_id'] = parentCategoryId;
    if (name != null) data['name'] = name;
    if (children != null) {
      data['children'] = children!.map((child) {
        if (child is CategoryModel) {
          return child.toJson();
        }
        return {};
      }).toList();
    }
    return data;
  }
}
