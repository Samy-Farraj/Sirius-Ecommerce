import 'package:dartz/dartz.dart';

import 'package:osm/app/features/app/data/models/app_model.dart';
import 'package:osm/app/features/app/data/remote_datasources/app_remote_datasource.dart';
import 'package:osm/app/features/app/domain/repositories/app_repository.dart';

import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../domain/entities/app.dart';

class AppRepositoryImpl implements AppRepository {
  AppRemoteDatasource dataSource;

  AppRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, App>> getApps() async {
    try {
      ApiResponse response = await dataSource.getApps();
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          print("KDFKSDFSD");
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
