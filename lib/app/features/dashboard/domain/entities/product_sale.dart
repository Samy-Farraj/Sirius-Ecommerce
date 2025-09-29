import 'package:equatable/equatable.dart';

class ProductSale extends Equatable {
  int? id;
  int? purchaseCount;
  int? purchaseValue;
  String? title;
  String? firstImage;

  @override
  List<Object?> get props => [
        id,
        purchaseCount,
        purchaseValue,
        title,
        firstImage,
      ];

  ProductSale({
    this.id,
    this.purchaseCount,
    this.purchaseValue,
    this.title,
    this.firstImage,
  });
}
