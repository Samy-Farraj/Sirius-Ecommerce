import 'package:dartz/dartz.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/FilterEntity.dart';
import '../repositories/filters_repository.dart';

class GetFilterValueUseCase implements BaseUseCase<FilterEntity, NoParameters> {
  final BaseFiltersRepository repository;

  const GetFilterValueUseCase(this.repository);

  @override
  Future<Either<Failure, FilterEntity>> call(NoParameters) {
    return repository.getFilterValue();
  }
}
