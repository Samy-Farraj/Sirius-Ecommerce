class SubCategoryFilterModel {
  int id;
  String image;
  int? parentCategoryId;
  String name;

  SubCategoryFilterModel({
    required this.id,
    required this.image,
    required this.parentCategoryId,
    required this.name,
  });

  factory SubCategoryFilterModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryFilterModel(
        id: json["id"],
        image: json["image"],
        parentCategoryId: json["parent_category_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "parent_category_id": parentCategoryId,
        "name": name,
      };
}
