import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';

class MyColorModel extends MyColor {
  MyColorModel({
    super.id,
    super.combinedWith,
    super.name,
    super.hashcode,
    super.createdAt,
    super.updatedAt,
  });

  factory MyColorModel.fromJson(Map<String, dynamic> map) {
    return MyColorModel(
      id: map['id'] != null ? map['id'] as int : null,
      combinedWith: map['combined_with'] != null
          ? MyColorModel.fromJson(map['combined_with'] as Map<String, dynamic>)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      hashcode: map['hash_code'] != null ? map['hash_code'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (combinedWith != null && combinedWith is MyColorModel) {
      data['combined_with'] = (combinedWith as MyColorModel).toJson();
    }
    if (name != null) data['name'] = name;
    if (hashCode != null) data['hash_code'] = hashCode;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    return data;
  }
}
