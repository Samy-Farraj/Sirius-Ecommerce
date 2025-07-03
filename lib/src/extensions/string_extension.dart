import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringExtensions on String {
  Widget svg({
    double? h,
    double? w,
    Color? color,
    bool isDirectional = false,
  }) =>
      SvgPicture.asset(
        this,
        height: h,
        width: w,
        matchTextDirection: isDirectional,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
      );

  String removeLast() => substring(0, length - 1);
  String removeLastTwo() => substring(0, length - 2);
}
