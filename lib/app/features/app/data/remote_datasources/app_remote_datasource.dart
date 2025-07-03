import 'dart:convert';
import 'dart:io';

import 'package:osm/app/features/app/data/models/app_model.dart';

import 'package:osm/app/features/app/data/models/app_model.dart';
import 'package:osm/app/features/app/domain/entities/app.dart';

import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';

class AppRemoteDatasource {
  final DioHelper dioHelper;
  AppRemoteDatasource({required this.dioHelper});
  Future<ApiResponse<AppModel>> getApps() async {
    final queryParameters = {
      // 'platform': (Platform.isAndroid == true
      //         ? AppPlatform.android
      //         : Platform.isIOS == true
      //             ? AppPlatform.ios
      //             : AppPlatform.web)
      //     .name,
      'page': 0,
      'pageSize': 1000
    };
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.getApps,
      );
      ApiResponse<AppModel> response = ApiResponse.fromJson(
          responseBody.data, (data) => AppModel.fromJson(responseBody.data));
      // myList.add(response.data!);
      // ApiResponse<AppModel> response = ApiResponse.fromJson(
      //   responseBody.data,
      //       (data) => (data as List).map((e) => AppModel.fromJson(e)).where((a) =>
      //       a.platform ==
      //           (Platform.isAndroid ? AppPlatform.android : AppPlatform.ios))
      //           .toList(),
      // );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
