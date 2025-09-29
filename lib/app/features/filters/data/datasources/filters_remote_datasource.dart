import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';

import '../models/filter_entity_model.dart';

abstract class BaseFiltersDataSource {
  Future<ApiResponse<FilterEntityModel>> getFilterValue();
}

class FiltersDataSource extends BaseFiltersDataSource {
  final DioHelper dioHelper;

  FiltersDataSource({required this.dioHelper});

  @override
  Future<ApiResponse<FilterEntityModel>> getFilterValue() async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.getFilterValue,
      );

      ApiResponse<FilterEntityModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => FilterEntityModel.fromJson(data),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
