import 'package:dartz/dartz.dart';

import '../../../../../src/core/data_sources/remote/api_endpoints.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/core/data_sources/remote/helpers/dio_helper.dart';
import '../../../../../src/error/exceptions.dart';
import '../../domain/usecases/store_new_branch_use_case.dart';

abstract class BranchesDataSource {
  Future<ApiResponse> updateBranch(NewBranchParameter parameters);
  Future<ApiResponse> storeNewBranch(NewBranchParameter parameters);
  Future<ApiResponse> deleteBranch(String branchId);
}

class BranchesDataSourceImpl extends BranchesDataSource {
  final DioHelper dioHelper;

  BranchesDataSourceImpl({required this.dioHelper});

  @override
  Future<ApiResponse> deleteBranch(String branchId) async {
    try {
      final responseBody = await dioHelper.delete(
        url: ApiEndpoints.deleteBranchById + branchId,
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
  Future<ApiResponse> storeNewBranch(NewBranchParameter parameters) async {
    try {
      final responseBody = await dioHelper.post(
        url: ApiEndpoints.storeBranch,
        data: {
          "city_id": parameters.cityId,
          "company_id": parameters.companyId,
          "title": parameters.title,
          "address": parameters.address,
          "longitude": parameters.longitude,
          "latitude": parameters.latitude,
        },
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
  Future<ApiResponse> updateBranch(NewBranchParameter parameters) async {
    try {
      final responseBody = await dioHelper.post(
        url: ApiEndpoints.updateBranchById + parameters.branchId.toString(),
        data: {
          "city_id": parameters.cityId,
          "company_id": parameters.companyId,
          "title": parameters.title,
          "address": parameters.address,
          "longitude": parameters.longitude,
          "latitude": parameters.latitude,
        },
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
