import 'package:sirius/app/features/color/data/models/my_color_model.dart';

import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';

abstract class BaseColorsDataSource {
  Future<ApiResponse<List<MyColorModel>>> getAllColors();
}

class ColorsDataSource extends BaseColorsDataSource {
  final DioHelper dioHelper;

  ColorsDataSource({required this.dioHelper});

  @override
  Future<ApiResponse<List<MyColorModel>>> getAllColors() async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.getColors,
      );
      print(responseBody.data);
      ApiResponse<List<MyColorModel>> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => (data as List).map((e) => MyColorModel.fromJson(e)).toList(),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
