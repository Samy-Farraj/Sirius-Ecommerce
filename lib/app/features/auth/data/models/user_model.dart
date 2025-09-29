import 'package:json_annotation/json_annotation.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../branches/domain/entities/branch.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../categories/domain/entities/category.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/photo.dart';

class UserModel extends AppUser {
  UserModel({
    super.id,
    super.userId,
    super.branches,
    super.categories,
    super.name,
    super.email,
    super.phone,
    super.description,
    super.logo,
    super.cover,
    super.lang,
    super.muteNotification,
    super.mode,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      branches: map['branches'] != null
          ? List<Branch>.from(
              (map['branches'] as List).map((e) => BranchModel.fromJson(e)))
          : null,
      categories: map['categories'] != null
          ? List<Category>.from(
              (map['categories'] as List).map((e) => CategoryModel.fromJson(e)))
          : null,
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      cover: map['cover'] != null ? map['cover'] as String : null,
      lang: map['lang'] != null ? map['lang'] as String : null,
      muteNotification: map['mute_notification'] != null
          ? map['mute_notification'] as int
          : null,
      mode: map['mode'] != null ? map['mode'] as String : null,
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
    if (lang != null) data['lang'] = lang;
    if (muteNotification != null) data['mute_notification'] = muteNotification;
    if (mode != null) data['mode'] = mode;
    return data;
  }
}
