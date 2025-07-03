// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'api_response.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// ApiResponse<T> _$ApiResponseFromJson<T>(
//   Map<String, dynamic> json,
//   T Function(Object? json) fromJsonT,
// ) =>
//     ApiResponse<T>()
//       ..status = $enumDecodeNullable(_$ApiResponseStatusEnumMap, json['status'])
//       ..message = json['message'] as String?
//       ..data = _$nullableGenericFromJson(json['data'], fromJsonT)
//       ..error = json['error'];
//
// Map<String, dynamic> _$ApiResponseToJson<T>(
//   ApiResponse<T> instance,
//   Object? Function(T value) toJsonT,
// ) =>
//     <String, dynamic>{
//       'status': _$ApiResponseStatusEnumMap[instance.status],
//       'message': instance.message,
//       'data': _$nullableGenericToJson(instance.data, toJsonT),
//       'error': instance.error,
//     };
//
// const _$ApiResponseStatusEnumMap = {
//   ApiResponseStatus.success: 'success',
//   ApiResponseStatus.error: 'error',
//   ApiResponseStatus.sessionExpired: 'sessionExpired',
// };
//
// T? _$nullableGenericFromJson<T>(
//   Object? input,
//   T Function(Object? json) fromJson,
// ) =>
//     input == null ? null : fromJson(input);
//
// Object? _$nullableGenericToJson<T>(
//   T? input,
//   Object? Function(T value) toJson,
// ) =>
//     input == null ? null : toJson(input);
