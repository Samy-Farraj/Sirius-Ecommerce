import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/paginated_product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase
    implements BaseUseCase<PaginatedProduct, GetProductParams> {
  final BaseProductRepository repository;

  const GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, PaginatedProduct>> call(GetProductParams params) {
    return repository.getProducts(params);
  }
}

class GetProductParams extends Equatable {
  int? page;
  int? perPage;
  String? search;
  String? status;
  String? pricingType;
  String? purchaseType;
  String? sortBy;
  String? sortDirection;
  String? minPrice;
  String? maxPrice;
  String? mine;
  List<String>? cityId;
  List<String>? stateId;
  List<String>? genders;
  List<String>? colors;
  List<String>? subCategories;
  List<String>? categoryId;
  List<String>? sizes;
  List<String>? companies;
  String? favourite;

  GetProductParams({
    this.pricingType,
    this.companies,
    this.purchaseType,
    this.subCategories,
    this.genders,
    this.sortBy,
    this.sortDirection,
    this.colors,
    this.sizes,
    this.page,
    this.stateId,
    this.perPage,
    this.search,
    this.status,
    this.minPrice,
    this.maxPrice,
    this.mine,
    this.cityId,
    this.categoryId,
    this.favourite,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        pricingType,
        companies,
        purchaseType,
        subCategories,
        genders,
        colors,
        sortDirection,
        sortBy,
        sizes,
        page,
        stateId,
        perPage,
        search,
        status,
        minPrice,
        maxPrice,
      ];
}
