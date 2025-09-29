import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';
import '../models/city_model.dart';

abstract class CityDataSource {
  Future<ApiResponse<List<CityModel>>> getAllCities();
}

class CityDataSourceImpl extends CityDataSource {
  final DioHelper dioHelper;

  CityDataSourceImpl({required this.dioHelper});

  @override
  Future<ApiResponse<List<CityModel>>> getAllCities() async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.getCities,
      );
      print(responseBody.data);
      ApiResponse<List<CityModel>> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => (data as List).map((e) => CityModel.fromJson(e)).toList(),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
