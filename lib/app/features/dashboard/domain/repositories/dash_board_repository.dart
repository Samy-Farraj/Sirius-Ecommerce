import 'package:dartz/dartz.dart';
import 'package:sirius/src/error/failure.dart';

import '../entities/statistics.dart';

abstract class DashBoardRepository {
  Future<Either<Failure, Statistics>> getAllStatistics(String period);
}
