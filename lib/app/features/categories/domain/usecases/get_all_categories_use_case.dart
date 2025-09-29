import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../entities/category.dart';
import '../repositories/categories_repository.dart';

class GetAllCategoriesUseCase
    extends BaseUseCase<List<Category>, NoParameters> {
  final BaseCategoriesRepository repository;

  GetAllCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(Noparameters) async {
    return await repository.getAllCategories();
  }
}
