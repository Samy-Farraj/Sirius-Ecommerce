class PriceRangeFilterModel {
  double minPrice;
  double maxPrice;

  PriceRangeFilterModel({
    required this.minPrice,
    required this.maxPrice,
  });

  factory PriceRangeFilterModel.fromJson(Map<String, dynamic> json) =>
      PriceRangeFilterModel(
        minPrice: json["min_price"]?.toDouble(),
        maxPrice: json["max_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "min_price": minPrice,
        "max_price": maxPrice,
      };
}
