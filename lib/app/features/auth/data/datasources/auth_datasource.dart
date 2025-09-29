import 'package:sirius/src/core/data_sources/remote/api_endpoints.dart';
import 'package:dio/dio.dart';

import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/di/services_locator.dart';

import '../../../../../src/error/exceptions.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/usecases/login_usecase.dart';

import '../models/auth_user_model.dart';
import '../models/register_response.dart';
import '../models/user_id_holder_model.dart';

abstract class BaseAuthDataSource {
  Future<ApiResponse> logOut();
  Future<ApiResponse<AuthUserModel>> login(LoginParameters parameters);
}

class AuthDataSource extends BaseAuthDataSource {
  final DioHelper dioHelper;

  AuthDataSource({required this.dioHelper});

  @override
  Future<ApiResponse> logOut() async {
    try {
      final responseBody =
          await dioHelper.post(url: ApiEndpoints.logoutCompany, data: {});
      print("THE USER LOGGGG OUTTT resss${responseBody.data}");

      return ApiResponse.fromJson(
        responseBody.data,
        (json) => json,
      );
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  @override
  Future<ApiResponse<AuthUserModel>> login(LoginParameters parameters) async {
    try {
      final responseBody = await dioHelper.post(
        data: {
          'email': parameters.phone,
          'password': parameters.password,
        },
        url: ApiEndpoints.login,
      );
      print(responseBody.data);
      return ApiResponse<AuthUserModel>.fromJson(
        responseBody.data,
        (data) => AuthUserModel.fromJson(data),
      );
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
