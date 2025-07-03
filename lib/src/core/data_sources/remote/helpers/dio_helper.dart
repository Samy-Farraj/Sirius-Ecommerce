import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio;

  DioHelper(this.dio);

  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.get(url, queryParameters: query, options: options);
  }

  Future<Response> post({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.post(url,
        data: data, queryParameters: query, options: options);
  }

  Future<Response> put({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.put(url,
        data: data, queryParameters: query, options: options);
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.delete(url, queryParameters: query, options: options);
  }
}
