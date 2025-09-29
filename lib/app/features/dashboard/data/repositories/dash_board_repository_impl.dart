import 'package:dartz/dartz.dart';
import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../domain/entities/statistics.dart';
import '../../domain/repositories/dash_board_repository.dart';
import '../datasources/dash_board_datasource.dart';

class DashBoardRepositoryImpl implements DashBoardRepository {
  final DashBoardDataSource dataSource;

  DashBoardRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Statistics>> getAllStatistics(String period) async {
    try {
      ApiResponse<Statistics> response =
          await dataSource.getAllStatistics(period);
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          showSuccessMessage(response);
          return Right(response.data!);
        }
      } else {
        showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
