import 'package:flutter/material.dart';

extension ConvertToMaterial on Color {
  toMaterialColor() {
    Map<int, Color> values = {
      50: withOpacity(.1),
      100: withOpacity(.2),
      200: withOpacity(.3),
      300: withOpacity(.4),
      400: withOpacity(.5),
      500: withOpacity(.6),
      600: withOpacity(.7),
      700: withOpacity(.8),
      800: withOpacity(.9),
      900: withOpacity(1),
    };
    return MaterialColor(value, values);
  }
}

extension AssetsPath on String {
  String get imageAssetPath => 'assets/images/$this';

  String get iconAssetPath => 'assets/icons/$this';
}

extension BoolConditions on bool? {
  bool get isNullOrFalse => this == null || this == false;
}
