import 'package:dartz/dartz.dart';
import 'package:sirius/src/error/failure.dart';

import '../entities/category.dart';

abstract class BaseCategoriesRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
