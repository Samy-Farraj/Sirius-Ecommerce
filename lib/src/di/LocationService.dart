import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sirius/src/di/services_locator.dart';

import '../core/data_sources/local/local_storage.dart';

class LocationService {
  static const String userAgent = 'CSC/2.0 (csc.taskati.net)';
  static const String email = 'h2n345@gmail.com';
  static final _cache = <String, String>{};

  static Future<String> getAddressName(LatLng position) async {
    final cacheKey = '${position.latitude},${position.longitude}';

    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    await Future.delayed(const Duration(seconds: 1));

    try {
      LocalStorage localStorage = sl.get<LocalStorage>();
      final response = await http.get(
        (localStorage.language == 'en')
            ? Uri.parse('https://nominatim.openstreetmap.org/reverse?'
                'format=jsonv2&'
                'lat=${position.latitude}&'
                'lon=${position.longitude}&'
                'accept-language=en&'
                'email=$email')
            : Uri.parse('https://nominatim.openstreetmap.org/reverse?'
                'format=jsonv2&'
                'lat=${position.latitude}&'
                'lon=${position.longitude}&'
                'accept-language=ar&'
                'email=$email'),
        headers: {'User-Agent': userAgent},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = _extractArabicName(data);
        _cache[cacheKey] = address;
        return removeLastComma(address);
      }

      return 'مكان غير معروف';
    } catch (e) {
      return 'فشل في جلب البيانات';
    }
  }

  static String removeLastComma(String address) {
    if (address.isNotEmpty && address.endsWith(' , ')) {
      return address.substring(0, address.length - 1);
    }
    print("THE FIANL ADDRESS ${address}");
    return address.substring(0, address.length - 2);
  }

  static String _extractArabicName(Map<String, dynamic> data) {
    String finalName = "";
    if (data['address']['amenity'] != null) {
      finalName += data['address']['amenity'] + " , ";
    }
    if (data['address']['road'] != null) {
      finalName += data['address']['road'] + " , ";
    }
    if (data['address']['suburb'] != null) {
      finalName += data['address']['suburb'] + " , ";
    }
    if (data['address']['town'] != null) {
      finalName += data['address']['town'] + " , ";
    }
    if (data['address']['city'] != null) {
      finalName += data['address']['city'] + " , ";
    }
    if (data['address']['state'] != null) {
      finalName += data['address']['state'] + " , ";
    }

    print("address ${data['address']}");
    print(
        "address ${data['address']['amenity']} ${data['address']['road']} ${data['address']['suburb']} ${data['address']['town']} ${data['address']['city']}");
    final address = data['address'] as Map<String, dynamic>?;
    return removeLastComma(finalName);
    return address?['name:ar'] ??
        address?['village:ar'] ??
        data['display_name'] ??
        'موقع غير معروف';
  }
}
