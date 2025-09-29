import 'package:sirius/app/features/color/data/models/my_color_model.dart';

import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';
import '../models/size_entity_model.dart';

abstract class BaseSizeDataSource {
  Future<ApiResponse<List<SizeEntityModel>>> getAllSizes(String categoryId);
}

class SizeDataSource extends BaseSizeDataSource {
  final DioHelper dioHelper;

  SizeDataSource({required this.dioHelper});

  @override
  Future<ApiResponse<List<SizeEntityModel>>> getAllSizes(
      String categoryId) async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.getSizes + categoryId,
      );
      print(responseBody.data);
      ApiResponse<List<SizeEntityModel>> response = ApiResponse.fromJson(
        responseBody.data,
        (data) =>
            (data as List).map((e) => SizeEntityModel.fromJson(e)).toList(),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
