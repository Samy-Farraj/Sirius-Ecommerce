import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/paginated_product.dart';
import '../repositories/product_repository.dart';

class CreateNewProductUseCase
    implements BaseUseCase<Unit, NewProductParameter> {
  final BaseProductRepository repository;

  const CreateNewProductUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NewProductParameter parameter) {
    return repository.createNewProduct(parameter);
  }
}
