import 'package:dio/dio.dart';
import 'package:sirius/app/features/auth/data/models/user_model.dart';

import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';
import '../../domain/usecases/edit_profile_use_case.dart';

abstract class BaseMyProfileDataSource {
  Future<ApiResponse> deleteProfile();
  Future<ApiResponse<UserModel>> getProfileInfo();
  Future<ApiResponse> editProfile(EditProfileParameter parameters);
}

class MyProfileDataSource extends BaseMyProfileDataSource {
  final DioHelper dioHelper;

  MyProfileDataSource({required this.dioHelper});

  @override
  Future<ApiResponse<UserModel>> getProfileInfo() async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.show,
      );
      print(responseBody.data);
      ApiResponse<UserModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => UserModel.fromJson(data),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  Future<ApiResponse> editProfile(EditProfileParameter parameters) async {
    try {
      // إنشاء FormData لإرسال البيانات
      FormData formData = FormData();

      // إضافة الحقول النصية
      void addIfNotNull(String key, String? value) {
        if (value != null &&
            value.isNotEmpty &&
            value != "" &&
            value != "null") {
          formData.fields.add(MapEntry(key, value));
        }
      }

      addIfNotNull('name', parameters.name);
      addIfNotNull('password', parameters.password);
      addIfNotNull('password_confirmation', parameters.confirmPassword);
      addIfNotNull('old_password', parameters.oldPassword);
      addIfNotNull('description', parameters.description);
      addIfNotNull('email', parameters.email);
      addIfNotNull('phone', parameters.phone);
      addIfNotNull('mode', parameters.mode);
      addIfNotNull('lang', parameters.lang);
      addIfNotNull('mute_notification', parameters.muteNotification.toString());

      if (parameters.logo != null) {
        formData.files.add(MapEntry(
          'logo',
          await MultipartFile.fromFile(
            parameters.logo!.path,
            filename: 'logo.jpg',
          ),
        ));
      }
      if (parameters.cover != null) {
        formData.files.add(MapEntry(
          'cover',
          await MultipartFile.fromFile(
            parameters.cover!.path,
            filename: 'cover.jpg',
          ),
        ));
      }
      final responseBody = await dioHelper.post(
        url: ApiEndpoints.updateProfile,
        data: formData,
      );
      print(responseBody.data);
      ApiResponse<UserModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => UserModel.fromJson(data),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  @override
  Future<ApiResponse> deleteProfile() async {
    try {
      final responseBody = await dioHelper.delete(
        url: ApiEndpoints.show,
      );
      print(responseBody.data);
      ApiResponse response = ApiResponse.fromJson(
        responseBody.data,
        (data) => data,
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
