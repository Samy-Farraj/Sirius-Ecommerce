import 'package:flutter/material.dart';

import '../utils/localization/app_languages.dart';

extension LocaleExtension on BuildContext {
  bool get isArabic => AppLanguages.isArabic;

  bool get isEnglish => AppLanguages.isEnglish;
}
