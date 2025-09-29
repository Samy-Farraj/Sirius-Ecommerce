import 'package:dartz/dartz.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/paginated_product.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase implements BaseUseCase<Unit, String> {
  final BaseProductRepository repository;

  const DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String productId) {
    return repository.deleteProductById(productId);
  }
}
