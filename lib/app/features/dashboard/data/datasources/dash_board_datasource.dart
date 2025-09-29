import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';
import '../models/statistics_model.dart';

abstract class DashBoardDataSource {
  Future<ApiResponse<StatisticsModel>> getAllStatistics(String period);
}

class DashBoardDataSourceImpl extends DashBoardDataSource {
  final DioHelper dioHelper;

  DashBoardDataSourceImpl({required this.dioHelper});

  @override
  Future<ApiResponse<StatisticsModel>> getAllStatistics(String period) async {
    try {
      final responseBody = await dioHelper
          .get(url: ApiEndpoints.getStatics, query: {'period': period});
      print(responseBody.data);

      ApiResponse<StatisticsModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => StatisticsModel.fromJson(data),
      );

      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }
}
