import '../../domain/entities/size_entity.dart';

class SizeEntityModel extends SizeEntity {
  const SizeEntityModel({
    super.id,
    super.name,
    super.categoryId,
    super.additionalInfo,
    super.createdAt,
    super.updatedAt,
  });

  factory SizeEntityModel.fromJson(Map<String, dynamic> map) {
    return SizeEntityModel(
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
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (categoryId != null) data['category_id'] = categoryId;
    if (additionalInfo != null) data['additional_info'] = additionalInfo;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    return data;
  }
}
