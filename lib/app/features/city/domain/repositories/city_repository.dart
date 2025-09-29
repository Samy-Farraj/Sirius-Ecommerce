import 'package:dartz/dartz.dart';
import 'package:sirius/src/error/failure.dart';

import '../entities/city.dart';

abstract class CityRepository {
  Future<Either<Failure, List<City>>> getAllCities();
}
