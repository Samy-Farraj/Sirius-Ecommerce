import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';
import '../models/category_model.dart';

abstract class BaseNotificationsDataSource {
  Future<ApiResponse<List<CategoryModel>>> getAllOffers();
}

class NotificationsDataSource extends BaseNotificationsDataSource {
  final DioHelper dioHelper;

  NotificationsDataSource({required this.dioHelper});

  @override
  Future<ApiResponse<List<CategoryModel>>> getAllOffers() async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.login,
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
