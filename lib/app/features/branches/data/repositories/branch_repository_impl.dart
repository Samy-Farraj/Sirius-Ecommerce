import 'package:dartz/dartz.dart';
import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../domain/repositories/branch_repository.dart';
import '../../domain/usecases/store_new_branch_use_case.dart';
import '../datasources/branches_datasource.dart';

class BranchesRepositoryImpl implements BranchesRepository {
  final BranchesDataSource dataSource;

  BranchesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Unit>> updateBranch(
      NewBranchParameter parameters) async {
    try {
      ApiResponse response = await dataSource.updateBranch(parameters);
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          showSuccessMessage(response);
          return Right(unit);
        }
      } else {
        showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBranch(String branchId) async {
    try {
      ApiResponse response = await dataSource.deleteBranch(branchId);
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          showSuccessMessage(response);
          return Right(unit);
        }
      } else {
        showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> storeNewBranch(
      NewBranchParameter parameters) async {
    try {
      ApiResponse response = await dataSource.storeNewBranch(parameters);
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          showSuccessMessage(response);
          return Right(unit);
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
