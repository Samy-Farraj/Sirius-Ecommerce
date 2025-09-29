class ProductImageModel {
  final String? url;
  final String? type;
  final int? order;

  const ProductImageModel({this.url, this.type, this.order});

  factory ProductImageModel.fromJson(Map<String, dynamic> map) {
    return ProductImageModel(
      url: map['url'] != null ? map['url'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      order: map['order'] != null ? map['order'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (url != null) data['url'] = url;
    if (type != null) data['type'] = type;
    if (order != null) data['order'] = order;
    return data;
  }
}
