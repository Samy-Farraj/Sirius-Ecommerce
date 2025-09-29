import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/statistics.dart';
import '../repositories/dash_board_repository.dart';

class GetAllStatisticsUseCase extends BaseUseCase<Statistics, String> {
  final DashBoardRepository repository;

  GetAllStatisticsUseCase(this.repository);

  @override
  Future<Either<Failure, Statistics>> call(String period) async {
    return await repository.getAllStatistics(period);
  }
}
