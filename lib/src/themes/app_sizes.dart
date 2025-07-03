import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  static final double _verticalPadding = 10.h;
  static final double _horizontalPadding = 16.w;

  static EdgeInsets get pagePadding => EdgeInsets.symmetric(
        vertical: _verticalPadding,
        horizontal: _horizontalPadding,
      );

  static const double appBarHeight = 70;
  static const double borderWidth0 = 0;
  static const double buttonRadius = 8;

  static const double appBarRadius = 16;
  static const double cardRadius = 8;
  static const double cardBigRadius = 16;
  static const double discountRadius = 21;

  static const double borderRadius = 12;
  static const double dialogRadius = 16;
  static const double verificationRadius = 16;

  static final double productServiceCardWidth = 396.w;
  static final double productServiceCardHeight = 131.h;

  static const double borderWidth2 = 2;
  static const double borderWidth1 = 1;

  static BoxConstraints prefixTextFieldConstraint =
      const BoxConstraints(maxHeight: 24, maxWidth: 50);
  static const double prefixTextFieldHPadding = 10;
}
