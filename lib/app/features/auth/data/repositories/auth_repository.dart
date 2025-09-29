import 'package:dartz/dartz.dart';

import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../../src/pusher/pusher_manager.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/base_auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../datasources/auth_datasource.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthDataSource baseAuthDataSource;

  AuthRepository(this.baseAuthDataSource);

  @override
  Future<Either<Failure, AuthUser>> login(LoginParameters parameters) async {
    try {
      ApiResponse<AuthUser> response =
          await baseAuthDataSource.login(parameters);
      if (response.hasSucceeded) {
        showSuccessMessage(response);
        print("THE RESPONSE1 ${response}");

        _handleUser(response);
        // _handleUser(
        //   response,
        //   rememberMe: parameters.rememberMe,
        // );

        if (response.data == [] || response.data == null) {}
        return Right(response.data!);
      } else {
        showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  Future<void> _handleUser(ApiResponse<AuthUser> response,
      {bool? rememberMe}) async {
    if (response.data != null) {
      //  sl.registerLazySingleton<AuthUser>(() => response.data!);
      LocalStorage localStorage = sl.get<LocalStorage>();
      localStorage.storeIsActive(true);
      if (localStorage.isUserAnonymous) {
        // await _updateAnonymourUserIdToUserId(
        //   localStorage.getUserId(),
        //   response.data!.user.id,
        // );
      }
      localStorage.storeAppUser(response.data!.company!);

      localStorage.storeToken(response.data!.token!);
      if (rememberMe != null) {
        localStorage.storeRememberMe(rememberMe);
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      ApiResponse response = await baseAuthDataSource.logOut();
      if (response.hasSucceeded) {
        print("THE USER LOGGGG OUTTT");
        LocalStorage localStorage = sl.get<LocalStorage>();
        localStorage.clearOnLogout();
        return const Right(unit);
      } else {
        LocalStorage localStorage = sl.get<LocalStorage>();

        localStorage.clearOnLogout();
        print(response.toString());
        if (response.error != null) {
          if (response.error['hintMesage'] != null) {
            AppNotifications.showError(
                message: response.error['hintMesage'].toString());
          } else {
            showErrorMessage(response);
          }
        }
        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
