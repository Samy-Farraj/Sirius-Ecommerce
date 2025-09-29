import 'package:dartz/dartz.dart';
import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../domain/entities/FilterEntity.dart';
import '../../domain/repositories/filters_repository.dart';
import '../datasources/filters_remote_datasource.dart';

class FiltersRepositoryImpl implements BaseFiltersRepository {
  BaseFiltersDataSource dataSource;

  FiltersRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, FilterEntity>> getFilterValue() async {
    try {
      ApiResponse<FilterEntity> response = await dataSource.getFilterValue();
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
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
