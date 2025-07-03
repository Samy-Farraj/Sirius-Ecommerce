// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class App extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? versionName;
  final int? versionCode;
  final bool? isRequired;
  final AppPlatform? platform;
  final int? delayToRequire;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  const App({
    this.id,
    required this.name,
    this.description,
    required this.versionName,
    required this.versionCode,
    required this.isRequired,
    required this.platform,
    required this.delayToRequire,
    this.updatedAt,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        versionName,
        versionCode,
        isRequired,
        platform,
        delayToRequire,
        updatedAt,
        createdAt
      ];
}

enum AppPlatform {
  android,
  ios,
}
