// To parse this JSON data, do
//
//     final newProductParameter = newProductParameterFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:sirius/app/features/product/data/models/product_image_model.dart';

NewProductParameter newProductParameterFromJson(String str) =>
    NewProductParameter.fromJson(json.decode(str));

String newProductParameterToJson(NewProductParameter data) =>
    json.encode(data.toJson());

class NewProductParameter {
  int? productId;
  int companyId;
  String name;
  String description;
  String gender;
  int isOnSale;
  int isReplaceable;
  int isRefundable;
  int points;
  double price;
  List<ProductImageModel>? oldImageUrl;
  List<int> categories;
  List<Branch> branches;
  List<File> images;

  NewProductParameter({
    required this.companyId,
    this.productId,
    required this.price,
    required this.name,
    required this.description,
    this.oldImageUrl,
    required this.gender,
    required this.isOnSale,
    required this.isReplaceable,
    required this.isRefundable,
    required this.points,
    required this.categories,
    required this.branches,
    required this.images,
  });

  factory NewProductParameter.fromJson(Map<String, dynamic> json) =>
      NewProductParameter(
        companyId: json["company_id"],
        name: json["name"],
        description: json["description"],
        gender: json["gender"],
        isOnSale: json["is_on_sale"],
        isReplaceable: json["is_replaceable"],
        isRefundable: json["is_refundable"],
        points: json["points"],
        oldImageUrl: json['oldImageUrl'] != null
            ? (json['oldImageUrl'] as List)
            .map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
            .toList()
            : null,
        categories: List<int>.from(json["categories"].map((x) => x)),
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),

        price: 0.0, images: [],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "name": name,
        "description": description,
        "gender": gender,
        "images": images,
        "is_on_sale": isOnSale,
        "is_replaceable": isReplaceable,
        "is_refundable": isRefundable,
        "points": points,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  int branchId;
  double price;
  List<Color> colors;

  Branch({
    required this.branchId,
    required this.price,
    required this.colors,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchId: json["branch_id"],
        price: json["price"]?.toDouble(),
        colors: List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "price": price,
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
      };
}

class Color {
  int colorId;
  List<Size> sizes;

  Color({
    required this.colorId,
    required this.sizes,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        colorId: json["color_id"],
        sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "color_id": colorId,
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
      };
}

class Size {
  int sizeId;
  int quantity;

  Size({
    required this.sizeId,
    required this.quantity,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        sizeId: json["size_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "size_id": sizeId,
        "quantity": quantity,
      };
}
