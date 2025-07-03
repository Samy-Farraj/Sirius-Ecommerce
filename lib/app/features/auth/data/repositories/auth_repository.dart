import 'package:dartz/dartz.dart';

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
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/resend_code_usecase.dart';
import '../../domain/usecases/verify_code_usecase.dart';
import '../datasources/auth_datasource.dart';
import '../models/auth_user_model.dart';
import '../models/register_response.dart';
import '../models/user_id_holder_model.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthDataSource baseAuthDataSource;

  AuthRepository(this.baseAuthDataSource);

  @override
  Future<Either<Failure, Unit>> login(LoginParameters parameters) async {
    try {
      ApiResponse response = await baseAuthDataSource.login(parameters);
      if (response.hasSucceeded) {
        _showSuccessMessage(response);
        // _handleUser(
        //   response,
        //   rememberMe: parameters.rememberMe,
        // );
        return const Right(unit);
      } else {
        print(response.toString());
        if (response.error != null) {
          if (response.error['hintMesage'] != null) {
            AppNotifications.showError(
                message: response.error['hintMesage'].toString());
          } else {
            _showErrorMessage(response);
          }
        }
        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> verifyCode(
      VerifyCodeParameters parameters) async {
    try {
      ApiResponse<AuthUser> response =
          await baseAuthDataSource.verifyCode(parameters);
      if (response.hasSucceeded) {
        print("THE RESPONSE1 ${response}");

        _showSuccessMessage(response);
        _handleUser(response);

        print("THE RESPONSE2 ${response}");

        AuthUser newUser = AuthUser(
            new AppUser(
              id: -1,
              birthDate: DateTime.now(),
              notificationToken: '',
              macAddress: '',
              gender: "male",
              profilePhoto: '',
              lang: '',
              lastName: '',
              firstName: '',
              email: '',
              phone: '',
              userType: '',
              isDriver: false,
            ),
            "");
        if (response.data == [] || response.data == null) {}
        return Right((response.data == null) ? newUser : response.data!);
      } else {
        print("THE  ErrorRESPONSE ${response}");
        _showErrorMessage(response);
        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> register(
      RegisterParameters parameters) async {
    try {
      ApiResponse<AuthUser> response =
          await baseAuthDataSource.register(parameters);
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          print("IAMGE HERE1");
          _showSuccessMessage(response);
          print("IAMGE HERE2");
          _handleUser(response);
          print("IAMGE HERE3");

          return Right(response.data!);
        }
      } else {
        print("IAMGE HERE4");
        _showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

/*
  @override
  Future<Either<Failure, AppUser>> register(
      RegisterParameters parameters) async {
    try {
      ApiResponse<RegisterResponse> response =
          await baseAuthDataSource.register(parameters);
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          _showSuccessMessage(response);
          return Right(response.data!.userData);
        }
      } else {
        _showErrorMessage(response);
        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
 */
  @override
  Future<Either<Failure, Unit>> resendCode(
      ResendCodeParameters parameters) async {
    try {
      ApiResponse response = await baseAuthDataSource.resendCode(parameters);
      if (response.hasSucceeded) {
        _showSuccessMessage(response);
        return const Right(unit);
      } else {
        _showErrorMessage(response);
        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  // _updateAnonymourUserIdToUserId(anonymousId, userId) async {
  //   final response =
  //       await baseAuthDataSource.updateUserId(UpdateUserIdParameters(
  //     anonymousId: anonymousId,
  //     userId: userId,
  //   ));
  //   if (response.hasFailed) {
  //     _showErrorMessage(response);
  //   }
  // }

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
      localStorage.storeAppUser(response.data!.user!);

      localStorage.storeToken(response.data!.token!);
      if (rememberMe != null) {
        localStorage.storeRememberMe(rememberMe);
      }
    }
  }

  void _showErrorMessage(ApiResponse response) {
    String errorMessage = 'Error happened';

    if (response.error != null) {
      if (response.error is Map<String, dynamic>) {
        if (response.error!.containsKey('error_messages')) {
          List<dynamic> errorMessages = response.error!['error_messages'];
          if (errorMessages.isNotEmpty) {
            errorMessage = errorMessages.join(', '); // تجميع الرسائل في نص واحد
          }
        } else if (response.error!.containsKey('message')) {
          errorMessage = response.error!['message'];
        }
      }
    }

    // إذا لم يتم العثور على رسالة خطأ في `error`، استخدم `response.message`
    if (errorMessage == 'Error happened' && response.message != null) {
      errorMessage = response.message!;
    }

    AppNotifications.showError(message: errorMessage);
  }

  void _showSuccessMessage(ApiResponse response) {
    AppNotifications.showSuccess(
      message: (response.message == null || response.message!.isEmpty)
          ? 'Success'
          : response.message!,
    );
  }

  @override
  Future<Either<Failure, Unit>> logOut(bool isDriver) async {
    try {
      ApiResponse response = await baseAuthDataSource.logOut(isDriver);
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
            _showErrorMessage(response);
          }
        }
        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
//
// void _showErrorMessage(ApiResponse response) {
//   AppNotifications.showError(
//     message: (response.error == null || response.error.toString().isEmpty)
//         ? 'Error happened'
//         : response.error?['no_connection'] != null &&
//                 response.error?['no_connection'] == true
//             ? response.message!
//             : response.error.toString(),
//   );
// }
}
