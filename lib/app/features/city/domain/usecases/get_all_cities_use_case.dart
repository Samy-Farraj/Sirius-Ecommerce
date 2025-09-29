import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../entities/city.dart';
import '../repositories/city_repository.dart';

class GetAllCitiesUseCase extends BaseUseCase<List<City>, NoParameters> {
  final CityRepository repository;

  GetAllCitiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(Noparameters) async {
    return await repository.getAllCities();
  }
}
