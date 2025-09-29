import 'dart:developer';

import 'package:sirius/app/features/color/data/models/my_color_model.dart';

import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/error/exceptions.dart';
import '../../domain/usecases/get_products_use_case.dart';
import '../models/NewProductParameter.dart';

import '../models/new_product_parameter_to_form_data.dart';
import '../models/paginated_product_model.dart';
import '../models/product_model.dart';

abstract class BaseProductDataSource {
  Future<ApiResponse<PaginatedProductModel>> getProducts(
      GetProductParams params);
  Future<ApiResponse<ProductModel>> showProductDetailsById(String productId);
  Future<ApiResponse> deleteProductById(String productId);
  Future<ApiResponse> createNewProduct(NewProductParameter parameter);
  Future<ApiResponse> editProduct(NewProductParameter parameter);
}

class ProductDatasource extends BaseProductDataSource {
  final DioHelper dioHelper;

  ProductDatasource({required this.dioHelper});

  @override
  Future<ApiResponse<PaginatedProductModel>> getProducts(
      GetProductParams params) async {
    Map<String, dynamic> dataQuery = {};
    if (params.status != null && params.status != "") {
      dataQuery['status[]'] = params.status;
    }

    if (params.pricingType != null && params.pricingType != "") {
      dataQuery['pricing_type'] = params.pricingType;
    }
    if (params.sortBy != null &&
        params.sortBy != "" &&
        params.sortBy != "null") {
      dataQuery['sort_by'] = params.sortBy;
    }
    if (params.sortDirection != null &&
        params.sortDirection != "" &&
        params.sortDirection != "null") {
      dataQuery['sort_direction'] = params.sortDirection;
    }
    if (params.purchaseType != null && params.purchaseType != "") {
      dataQuery['purchase_type'] = params.purchaseType;
    }

    if (params.page != null && params.page != "") {
      dataQuery['page'] = params.page;
    }
    if (params.perPage != null && params.perPage != "") {
      dataQuery['per_page'] = params.perPage;
    }
    if (params.search != null && params.search != "") {
      dataQuery['search'] = params.search;
    }
    if (params.categoryId != null && params.categoryId != "") {
      // dataQuery['category_id'] = params.categoryId;
      dataQuery['sub_categories[]'] = params.categoryId;
    }
    LocalStorage localStorage = sl.get<LocalStorage>();
    params.companies = [localStorage.appUser?.id.toString() ?? ""];
    if (params.companies != null && params.companies != "") {
      // dataQuery['category_id'] = params.categoryId;
      dataQuery['companies[]'] = params.companies;
    }
    if (params.genders != null && params.genders != "") {
      // dataQuery['category_id'] = params.categoryId;
      dataQuery['genders[]'] = params.genders;
    }
    if (params.colors != null && params.colors != "") {
      // dataQuery['category_id'] = params.categoryId;
      dataQuery['colors[]'] = params.colors;
    }
    if (params.subCategories != null && params.subCategories != "") {
      // dataQuery['category_id'] = params.categoryId;
      dataQuery['sub_categories[]'] = params.subCategories;
    }
    if (params.sizes != null && params.sizes != "") {
      // dataQuery['category_id'] = params.categoryId;
      dataQuery['sizes[]'] = params.sizes;
    }
    if (params.minPrice != null &&
        params.minPrice != "" &&
        params.minPrice != "null") {
      dataQuery['min_price'] = params.minPrice;
    }
    if (params.maxPrice != null &&
        params.maxPrice != "" &&
        params.maxPrice != "null") {
      dataQuery['max_price'] = params.maxPrice;
    }
    if (params.cityId != null && params.cityId != "") {
      dataQuery['city_id[]'] = params.cityId;
    }
    if (params.stateId != null && params.stateId != "") {
      dataQuery['state_id[]'] = params.stateId;
    }
    try {
      print("dataQuery${dataQuery}");
      final responseBody = await dioHelper.get(
          url: ApiEndpoints.getAllProduct, query: dataQuery);
      log("THE RESSSSS${responseBody}");
      ApiResponse<PaginatedProductModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => PaginatedProductModel.fromJson(data),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  @override
  Future<ApiResponse<ProductModel>> showProductDetailsById(
      String productId) async {
    try {
      final responseBody = await dioHelper.get(
        url: ApiEndpoints.getProductById + productId,
      );

      ApiResponse<ProductModel> response = ApiResponse.fromJson(
        responseBody.data,
        (data) => ProductModel.fromJson(data),
      );
      return response;
    } on ServerException catch (e) {
      print(e);
      throw ServerException(errorMessageModel: e.errorMessageModel);
    }
  }

  @override
  Future<ApiResponse> deleteProductById(String productId) async {
    try {
      final responseBody = await dioHelper.delete(
        url: ApiEndpoints.deleteProductById + productId,
      );

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
  Future<ApiResponse> createNewProduct(NewProductParameter parameter) async {
    try {
      final formData = await newProductParameterToFormData(parameter);

      final responseBody = await dioHelper.post(
        url: ApiEndpoints.storeProduct,
        data: formData,
      );

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
  Future<ApiResponse> editProduct(NewProductParameter parameter) async {
    try {
      final formData = await newProductParameterToFormData(parameter);

      final responseBody = await dioHelper.post(
        url: ApiEndpoints.storeProduct + '/' + parameter.productId.toString(),
        data: formData,
      );

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
