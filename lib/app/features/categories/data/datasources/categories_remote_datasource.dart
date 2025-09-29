import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';
import '../models/category_model.dart';

abstract class BaseCategoriesDataSource {
  Future<ApiResponse<List<CategoryModel>>> getAllCategories();
}

class CategoriesDataSource extends BaseCategoriesDataSource {
  final DioHelper dioHelper;

  CategoriesDataSource({required this.dioHelper});

  @override
  Future<ApiResponse<List<CategoryModel>>> getAllCategories() async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.categories,
      );
      print(responseBody.data);
      ApiResponse<List<CategoryModel>> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => (data as List).map((e) => CategoryModel.fromJson(e)).toList(),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
