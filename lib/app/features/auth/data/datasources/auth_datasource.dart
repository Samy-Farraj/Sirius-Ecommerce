import 'package:osm/src/core/data_sources/remote/api_endpoints.dart';
import 'package:dio/dio.dart';

import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/di/services_locator.dart';

import '../../../../../src/error/exceptions.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/resend_code_usecase.dart';
import '../../domain/usecases/verify_code_usecase.dart';
import '../models/auth_user_model.dart';
import '../models/register_response.dart';
import '../models/user_id_holder_model.dart';

abstract class BaseAuthDataSource {
  Future<ApiResponse<AuthUserModel>> register(RegisterParameters parameters);

  Future<ApiResponse> login(LoginParameters parameters);

  Future<ApiResponse> logOut(bool isDriver);

  Future<ApiResponse> resendCode(ResendCodeParameters parameters);

  Future<ApiResponse<AuthUserModel>> verifyCode(
      VerifyCodeParameters parameters);
}

class AuthDataSource extends BaseAuthDataSource {
  final DioHelper dioHelper;

  AuthDataSource({required this.dioHelper}); // تمرير DioHelper مباشرة

  @override
  Future<ApiResponse> login(LoginParameters parameters) async {
    try {
      final responseBody = await dioHelper.post(
        data: {'phone': parameters.phone},
        url: ApiEndpoints.login,
      );

      print(responseBody.data);
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
  Future<ApiResponse<AuthUserModel>> verifyCode(
      VerifyCodeParameters parameters) async {
    try {
      final responseBody = await dioHelper.post(
        data: {
          'phone': parameters.phone,
          'code': parameters.code,
          'notification_token': parameters.notification_token,
        },
        url: ApiEndpoints.verifyCode,
      );
      print("ٍresponseBody.data ${responseBody.data}");
      ApiResponse<AuthUserModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => (responseBody.data['data'] is Map<String, dynamic>)
            ? AuthUserModel.fromJson(data)
            : AuthUserModel(AppUser(), ""),
      );
      return response;
      // return ApiResponse.fromJson(
      //   responseBody.data,
      //   (json) {
      //     if (responseBody.data['data'] is Map<String, dynamic>) {
      //       print("THE responseBody.data ${responseBody.data}");
      //       print("THE jsonjson.json ${json}");
      //       print(
      //           "responseBody.data is Map<String, dynamic> ${responseBody.data is Map<String, dynamic>}");
      //       print(
      //           "AuthUserModel.fromJson(json['data']) ${AuthUserModel.fromJson(json)}");
      //       return AuthUserModel.fromJson(json);
      //     } else {
      //       return null;
      //     }
      //   },
      // );
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  @override
  Future<ApiResponse<AuthUserModel>> register(
      RegisterParameters parameters) async {
    try {
      final responseBody = await dioHelper.post(
        data: parameters.toMap(),
        url: ApiEndpoints.register,
      );
      ApiResponse<AuthUserModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => AuthUserModel.fromJson(data),
      );
      return response;
      // print(responseBody.data);
      // return ApiResponse.fromJson(responseBody.data, (json) {
      //   if (responseBody.data['data'] is Map<String, dynamic>) {
      //     print("THE responseBody.data ${responseBody.data}");
      //     print("THE jsonjson.json ${json}");
      //     print(
      //         "responseBody.data is Map<String, dynamic> ${responseBody.data is Map<String, dynamic>}");
      //     print(
      //         "AuthUserModel.fromJson(json['data']) ${AuthUserModel.fromJson(json)}");
      //     return AuthUserModel.fromJson(json);
      //   } else {
      //     return null; // أو يمكنك إرجاع كائن افتراضي إذا احتجت ذلك
      //   }
      // });
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  @override
  Future<ApiResponse> resendCode(ResendCodeParameters parameters) {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> logOut(bool isDriver) async {
    try {
      final responseBody = await dioHelper.get(
        url: (isDriver == true)
            ? ApiEndpoints.logOutDriver
            : ApiEndpoints.logOutClient,
      );
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
}
