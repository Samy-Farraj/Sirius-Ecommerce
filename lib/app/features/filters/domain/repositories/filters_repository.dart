import 'package:dartz/dartz.dart';
import 'package:sirius/src/error/failure.dart';
import '../entities/FilterEntity.dart';

abstract class BaseFiltersRepository {
  Future<Either<Failure, FilterEntity>> getFilterValue();
}
