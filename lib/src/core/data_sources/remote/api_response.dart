// import 'package:flutter/foundation.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../../enums/api_response_status.dart';
// import '../../../error/exceptions.dart';
//
// class ApiResponse<T> {
//   ApiResponseStatus? status;
//   String? message;
//   T? data;
//   dynamic error;
//
//   ApiResponse();
//   ApiResponse.success({this.message, this.data})
//       : status = ApiResponseStatus.success;
//
//   ApiResponse.error({this.message, this.error})
//       : status = ApiResponseStatus.error;
//
//   factory ApiResponse.fromJson(json, Function(Map<String, dynamic>) fromJsonT) {
//     if (kDebugMode) {
//       print('json : $json');
//     }
//     try {
//       if (json['status'] == 'Error') {
//         if (json['error']?['no_connection'] == true) {
//           return ApiResponse.error(
//             message: json['message'],
//             error: json['error'],
//           );
//         }
//         return ApiResponse.error(
//           message: json['message'],
//           error: json['data'],
//         );
//       } else {
//         if (json['statusCode'] == '101' && json['data']['hintMesage'] != null) {
//           return ApiResponse.error(
//             error: json['data'],
//             message: json['data']['hintMesage'],
//           );
//         } else {
//           return ApiResponse.success(
//             message: json['message'],
//             data: json['data'] is String
//                 ? json['data']
//                 : json['data'] is List
//                     ? fromJsonT(json)
//                     : fromJsonT(json['data'] is List<dynamic>
//                         ? {}
//                         : json['data'] is bool
//                             ? {'success': json['data']}
//                             : json['data'] ?? {}),
//           );
//         }
//       }
//     } catch (error) {
//       if (error is JsonObjectSerializeException) {
//         return ApiResponse.error(
//           message: error.message,
//         );
//       } else {
//         return ApiResponse.error(
//           message: error.toString(),
//         );
//       }
//     }
//   }
//
//   Map<String, dynamic> toJson() => {
//         'status': status.asString(),
//         'message': message,
//         'data': data,
//         'error': error,
//       };
//
//   @override
//   String toString() {
//     return 'ApiResponse{status: $status, message: $message, data: $data, error: $error}';
//   }
//
//   bool get hasSucceeded => status == ApiResponseStatus.success;
//
//   bool get hasFailed => status == ApiResponseStatus.error;
// }
import 'package:flutter/foundation.dart';
import '../../../enums/api_response_status.dart';
import '../../../error/exceptions.dart';

class ApiResponse<T> {
  final ApiResponseStatus status;
  final String? message;
  final T? data;
  final dynamic error;

  // Constructor خاص غير متاح للاستخدام المباشر
  ApiResponse._({
    required this.status,
    this.message,
    this.data,
    this.error,
  });

  /// حالة النجاح
  factory ApiResponse.success({String? message, T? data}) {
    return ApiResponse._(
      status: ApiResponseStatus.success,
      message: message,
      data: data,
    );
  }

  /// حالة الخطأ
  factory ApiResponse.error({String? message, dynamic error}) {
    return ApiResponse._(
      status: ApiResponseStatus.error,
      message: message,
      error: error,
    );
  }

  /// إنشاء استجابة من JSON
  /// [parseData] دالة لتحويل البيانات إلى النوع T سواء كانت Map أو List أو غير ذلك
  factory ApiResponse.fromJson(dynamic json, T Function(dynamic) parseData) {
    if (kDebugMode) {
      print('JSON: $json');
    }
    try {
      // إذا كانت البيانات من نوع Map
      if (json is Map<String, dynamic>) {
        // حالة الخطأ: عندما يكون المفتاح status يشير إلى خطأ أو رقم حالة يساوي 0
        if (json['status'] == 'Error' || json['status'] == 0) {
          // مثال: التحقق من حالة عدم الاتصال
          if (json['error'] != null && json['error']['no_connection'] == true) {
            return ApiResponse.error(
              message: json['message'],
              error: json['error'],
            );
          }
          return ApiResponse.error(
            message: json['message'],
            error: json['data'],
          );
        }
        // مثال آخر على حالة الخطأ الخاصة بـ statusCode مع hintMesage
        if (json['statusCode'] == '101' &&
            json['data'] is Map &&
            json['data']['hintMesage'] != null) {
          return ApiResponse.error(
            message: json['data']['hintMesage'],
            error: json['data'],
          );
        }
        // حالة النجاح: يتم تفسير البيانات
        dynamic rawData = json['data'];
        T parsedData = parseData(rawData);
        return ApiResponse.success(
          message: json['message'],
          data: parsedData,
        );
      }
      // إذا كان الجيسون عبارة عن List مباشرة
      else if (json is List) {
        T parsedData = parseData(json);
        return ApiResponse.success(data: parsedData);
      }
      // صيغة غير مدعومة
      else {
        return ApiResponse.error(
          message: 'صيغة JSON غير مدعومة',
          error: json,
        );
      }
    } catch (e) {
      if (e is JsonObjectSerializeException) {
        return ApiResponse.error(message: e.message, error: e);
      } else {
        return ApiResponse.error(message: e.toString(), error: e);
      }
    }
  }

  /// تحويل الاستجابة إلى JSON (مع استخدام دالة toJsonData لتحويل البيانات من النوع T)
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonData) {
    return {
      'status': status.asString(),
      'message': message,
      'data': data != null ? toJsonData(data as T) : null,
      'error': error,
    };
  }

  /// للتحقق من نجاح العملية
  bool get hasSucceeded => status == ApiResponseStatus.success;

  /// للتحقق من حدوث خطأ
  bool get isError => status == ApiResponseStatus.error;

  @override
  String toString() {
    return 'ApiResponse(status: ${status.asString()}, message: $message, data: $data, error: $error)';
  }
}
