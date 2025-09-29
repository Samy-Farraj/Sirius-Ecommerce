import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/data_sources/local/local_storage.dart';
import '../../di/services_locator.dart';
import 'app_locales.dart';

abstract class AppLanguages {
  static setLocale(BuildContext context, Locale locale) async {
    if (allLocales.contains(locale)) {
      print("SADASDAS${locale.languageCode}");
      context.setLocale(locale);
      await sl.get<LocalStorage>().storeLanguage(locale.languageCode);
      // Phoenix.rebirth(context);
    } else {
      throw Exception('App does not support this locale');
    }
  }

  static Locale get getCurrentLocale {
    Locale defaultLocale = arabicLocale;
    String? temp = sl.get<LocalStorage>().language;
    if (temp == null) {
      return defaultLocale;
    } else {
      switch (temp) {
        case 'ar':
          return arabicLocale;
        case 'en':
          return englishLocale;
        default:
          return defaultLocale;
      }
    }
  }

  static bool get isArabic => getCurrentLocale == arabicLocale;

  static bool get isEnglish => getCurrentLocale == englishLocale;
}
