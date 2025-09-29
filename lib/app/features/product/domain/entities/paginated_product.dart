import 'package:equatable/equatable.dart';
import 'package:sirius/app/features/product/domain/entities/product.dart';

class PaginatedProduct extends Equatable {
  final int? currentPage;
  final List<Product>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  @override
  List<Object?> get props => [
        currentPage,
        data,
        firstPageUrl,
        from,
        lastPage,
        perPage,
        to,
        total,
      ];

  PaginatedProduct({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  PaginatedProduct copyWith({
    int? currentPage,
    List<Product>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    int? perPage,
    int? to,
    int? total,
  }) {
    return PaginatedProduct(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }
}
