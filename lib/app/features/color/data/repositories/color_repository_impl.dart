import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../domain/repositories/color_repository.dart';
import '../datasources/color_remote_datasource.dart';

class ColorRepositoryImpl implements BaseColorRepository {
  final BaseColorsDataSource dataSource;

  ColorRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<MyColor>>> getAllColors() async {
    try {
      ApiResponse<List<MyColor>> response = await dataSource.getAllColors();
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
