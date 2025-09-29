import 'package:equatable/equatable.dart';

import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    super.id,
    super.userId,
    super.name,
    super.email,
    super.phone,
    super.description,
    super.logo,
    super.cover,
    super.createdAt,
    super.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      cover: map['cover'] != null ? map['cover'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (userId != null) data['user_id'] = userId;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (description != null) data['description'] = description;
    if (logo != null) data['logo'] = logo;
    if (cover != null) data['cover'] = cover;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    return data;
  }
}
