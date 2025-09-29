import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';

import 'NewProductParameter.dart';

Future<FormData> newProductParameterToFormData(
    NewProductParameter parameter) async {
  final formDataMap = <String, dynamic>{};

  formDataMap['company_id'] = parameter.companyId;
  formDataMap['name'] = parameter.name;
  formDataMap['description'] = parameter.description;
  formDataMap['gender'] = parameter.gender;
  formDataMap['is_on_sale'] = parameter.isOnSale;
  formDataMap['is_replaceable'] = parameter.isReplaceable;
  formDataMap['is_refundable'] = parameter.isRefundable;
  formDataMap['points'] = parameter.points;
  formDataMap['branches'] =
      List<dynamic>.from(parameter.branches.map((x) => x.toJson()));

  // معالجة التصنيفات (categories[])
  for (int i = 0; i < parameter.categories.length; i++) {
    formDataMap['categories[]'] = parameter.categories[i];
  }

  // // معالجة الفروع (branches[])
  // for (int i = 0; i < parameter.branches.length; i++) {
  //   final branch = parameter.branches[i];
  //   formDataMap['branches[]'] = branch.id; // مثال: لازم يكون عندك id أو أي key
  //   formDataMap['branches[]'] = branch.name;
  //   // أضف باقي الخصائص اللي في Branch بنفس الطريقة
  // }

  // معالجة الصور
// معالجة الصور
  formDataMap['images[]'] = []; // إنشاء قائمة فارغة أولاً

  for (int i = 0; i < parameter.images.length; i++) {
    if (parameter.images[i].path.toString() == "empty") {
      continue; // أو break حسب احتياجك
    }

    final file = parameter.images[i];
    final mimeType = lookupMimeType(file.path);

    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
      contentType: mimeType != null ? MediaType.parse(mimeType) : null,
    );

    // أضف الصورة إلى القائمة
    (formDataMap['images[]'] as List).add(multipartFile);
  }
  // print("THE LENGHT OF ARRAY ${parameter.images.length}");
  // for (int i = 0; i < parameter.images.length; i++) {
  //   if (parameter.images[i].path.toString() == "empty") {
  //     break;
  //   }
  //   final file = parameter.images[i];
  //   final mimeType = lookupMimeType(file.path);
  //   print("THE images OF ARRAY ${file}");
  //   final multipartFile = await MultipartFile.fromFile(
  //     file.path,
  //     filename: file.path.split('/').last,
  //     contentType: mimeType != null ? MediaType.parse(mimeType) : null,
  //   );
  //
  //   formDataMap['images[]'] = multipartFile;
  // }

  return FormData.fromMap(formDataMap);
}
