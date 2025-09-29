import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';

import '../../../branches/data/models/branch_model.dart';
import '../../../branches/domain/entities/branch.dart';
import '../../../categories/data/models/category_model.dart';
import 'photo.dart';

class AppUser extends Equatable {
  final int? id;
  final int? userId;
  final String? name;
  final String? email;
  final String? phone;
  final String? description;
  final String? logo;
  final String? cover;
  final String? lang;
  final int? muteNotification;
  final String? mode;
  List<Branch>? branches;
  List<Category>? categories;

  AppUser copyWith({
    final int? id,
    final int? userId,
    final String? name,
    final String? email,
    final String? phone,
    final String? description,
    final String? logo,
    final String? cover,
    final String? lang,
    final int? muteNotification,
    final String? mode,
    final List<Branch>? branches,
    final List<Category>? categories,
  }) {
    return AppUser(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      branches: branches ?? this.branches,
      categories: categories ?? this.categories,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      cover: cover ?? this.cover,
      lang: lang ?? this.lang,
      muteNotification: muteNotification ?? this.muteNotification,
      mode: mode ?? this.mode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        branches,
        categories,
        name,
        email,
        phone,
        description,
        logo,
        cover,
        lang,
        muteNotification,
        mode,
      ];

  AppUser({
    this.id,
    this.userId,
    this.branches,
    this.categories,
    this.name,
    this.email,
    this.phone,
    this.description,
    this.logo,
    this.cover,
    this.lang,
    this.muteNotification,
    this.mode,
  });

  factory AppUser.fromJson(Map<String, dynamic> map) {
    return AppUser(
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
