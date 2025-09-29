import 'package:dartz/dartz.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/paginated_product.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ShowProductDetailsByIdUseCase implements BaseUseCase<Product, String> {
  final BaseProductRepository repository;

  const ShowProductDetailsByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Product>> call(String productId) {
    return repository.showProductDetailsById(productId);
  }
}
