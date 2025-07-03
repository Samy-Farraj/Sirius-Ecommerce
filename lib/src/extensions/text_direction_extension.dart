import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'locale_extension.dart';

extension TextDirection on BuildContext {
  bool get isRTL => isArabic;

  bool get isLTR => isEnglish;

  ui.TextDirection get textDirection =>
      isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr;
}
