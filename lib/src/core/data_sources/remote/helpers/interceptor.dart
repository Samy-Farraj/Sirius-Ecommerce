import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../utils/app_notifications.dart';
import '../../local/local_storage.dart';
import '../api_response.dart';

class RemoteInterceptor extends InterceptorsWrapper {
  final LocalStorage storageProvider;

  RemoteInterceptor(this.storageProvider)
      : super(
          onRequest: (options, handler) async {
            print(
                "await sl.get<LocalStorage>().language??'en'${storageProvider.language ?? 'en'}");

            final headers = <String, String>{
              'Accept': 'application/json',
              'lang': storageProvider.language ?? 'en'
            };
            final params = <String, String>{
              'platform': (Platform.isAndroid) ? 'android' : 'ios'
            };
            options.headers = headers;
            final existingParams = options.queryParameters ?? {};
            options.queryParameters = {
              ...existingParams,
              ...params,
            };
            // options.queryParameters = params;
            final token = storageProvider.token;
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }

            List<ConnectivityResult> connectivityResults =
                await Connectivity().checkConnectivity();
            interceptorLog(
                'REQUEST CONNECTIVITY: ${connectivityResults.first.name}');
            if (connectivityResults.first == ConnectivityResult.none) {
              return handler.resolve(
                Response(
                  requestOptions: options,
                  data: _handleErrorResponse(null).toJson((data) => data),
                ),
              );
            }
            return handler.next(options);
          },
          onResponse: (response, handler) async {
            if (response.data is String) {
              return handler.resolve(
                Response(
                  data: ApiResponse.success(data: response.data).toJson(
                      (data) => data is Map<String, dynamic>
                          ? data
                          : {'value': data}),
                  requestOptions: response.requestOptions,
                ),
              );
            }

            return handler.next(response);
          },
          onError: (error, handler) {
            interceptorLog('ERROR: $error');
            return handler.resolve(
              Response(
                requestOptions: error.requestOptions,
                data: _handleErrorResponse(error.response,
                        path: error.requestOptions.path)
                    .toJson((data) => data),
              ),
            );
          },
        );

  static ApiResponse _handleErrorResponse(Response? response, {String? path}) {
    if (response == null) {
      AppNotifications.showError(message: LocaleKeys.no_connection.tr());
      return ApiResponse.error(
        message: LocaleKeys.no_connection.tr(),
        error: {'no_connection': true},
      );
    }
    print("IN INSEEEEE${response.data['message']}");
    switch (response.statusCode) {
      case 401:
        return ApiResponse.error(
          message: 'unauthorized'.tr(),
          error: response.data,
        );
      case 500:
        final res = ApiResponse.error(
            message: 'internal server error', error: response.data);
        AppNotifications.showError(message: res.message!);
        return res;
      case 403:
        final res = ApiResponse.error(
            message: 'unauthorized'.tr(), error: response.data);

        return res;
      default:
        return ApiResponse.error(
          message: response.data['message'] ?? 'Unknown Exception',
          error: response.data,
        );
    }
  }
}

void interceptorLog(String message) => log('[INTERCEPTOR]=> $message');
