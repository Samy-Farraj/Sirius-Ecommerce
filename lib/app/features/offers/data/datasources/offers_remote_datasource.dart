import 'package:dio/dio.dart';

import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/error/exceptions.dart';

import '../../domain/usecases/store_new_offer_use_case.dart';
import '../models/offer_model.dart';

abstract class OffersDataSource {
  Future<ApiResponse<List<OfferModel>>> getAllOffers();
  Future<ApiResponse> deleteOfferById(String offerId);
  Future<ApiResponse> storeNewOffer(StoreNewOfferParameter parameter);
}

class OffersDataSourceImpl extends OffersDataSource {
  final DioHelper dioHelper;

  OffersDataSourceImpl({required this.dioHelper});

  @override
  Future<ApiResponse<List<OfferModel>>> getAllOffers() async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.login,
      );
      print(responseBody.data);
      ApiResponse<List<OfferModel>> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => (data as List).map((e) => OfferModel.fromJson(e)).toList(),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  @override
  Future<ApiResponse> deleteOfferById(String offerId) async {
    try {
      final responseBody = await dioHelper.get(
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
  Future<ApiResponse> storeNewOffer(StoreNewOfferParameter parameter) async {
    try {
      final formData = FormData.fromMap({
        "end_date": parameter.endDate,
        "start_date": parameter.startDate,
        "discount_amount": parameter.discountAmount.toString(),
        "discount_type": parameter.discountType,
      });

      for (var id in parameter.productId) {
        formData.fields.add(MapEntry("product_ids[]", id.toString()));
      }

      final responseBody = await dioHelper.post(
        url: ApiEndpoints.addOffer,
        data: formData,
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
}
