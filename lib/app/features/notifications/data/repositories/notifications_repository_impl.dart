import 'package:dartz/dartz.dart';
import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_datasource.dart';

class NotificationsRepositoryImpl implements BaseNotificationsRepository {
  final BaseNotificationsDataSource dataSource;

  NotificationsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllOffers() async {
    try {
      ApiResponse<List<Category>> response = await dataSource.getAllOffers();
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
