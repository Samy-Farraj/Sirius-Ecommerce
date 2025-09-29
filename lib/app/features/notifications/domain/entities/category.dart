import 'package:equatable/equatable.dart';

class Category extends Equatable {
  int? id;
  String? slug;
  String? titleEn;
  String? titleAr;
  int? order;
  bool? showInNavbar;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;

  Category({
    this.id,
    this.slug,
    this.titleEn,
    this.titleAr,
    this.order,
    this.showInNavbar,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        slug,
        titleEn,
        titleAr,
        order,
        showInNavbar,
        createdAt,
        updatedAt,
        image,
      ];
}
