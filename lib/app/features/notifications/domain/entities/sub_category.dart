import 'package:equatable/equatable.dart';

class SubCategory extends Equatable {
  final int? id;
  final String? slug;
  final String? titleEn;
  final String? titleAr;
  final String? description;
  final dynamic? order;
  final dynamic? showInNavbar;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        id,
        slug,
        titleEn,
        titleAr,
        description,
        order,
        showInNavbar,
        createdAt,
        updatedAt,
      ];

  SubCategory({
    required this.id,
    required this.slug,
    required this.titleEn,
    required this.titleAr,
    required this.description,
    required this.order,
    required this.showInNavbar,
    required this.createdAt,
    required this.updatedAt,
  });
}
