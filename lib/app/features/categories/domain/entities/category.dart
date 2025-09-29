import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/product/domain/entities/pivot.dart';

class Category extends Equatable {
  int? id;
  String? image;
  Pivot? pivot;
  int? parentCategoryId;
  String? name;
  List<Category>? children;

  @override
  List<Object?> get props =>
      [id, pivot, image, parentCategoryId, name, children];

  Category({
    this.id,
    this.pivot,
    this.image,
    this.parentCategoryId,
    this.name,
    this.children,
  });
}
