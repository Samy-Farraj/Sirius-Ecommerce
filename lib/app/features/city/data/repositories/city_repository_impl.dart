import 'package:dartz/dartz.dart';
import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/city_repository.dart';
import '../datasources/city_datasource.dart';

class CityRepositoryImpl implements CityRepository {
  final CityDataSource dataSource;

  CityRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<City>>> getAllCities() async {
    try {
      ApiResponse<List<City>> response = await dataSource.getAllCities();
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
