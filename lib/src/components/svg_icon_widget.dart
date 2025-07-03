import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String iconTitle;
  final Color? color;
  final double? h;
  final double? w;
  final bool isDierctional;
  final VoidCallback? onTap; // أضف هذا

  const SvgIcon({
    super.key,
    required this.iconTitle,
    this.color,
    this.h,
    this.w,
    this.isDierctional = false,
    this.onTap, // وأ
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        iconTitle,
        height: h,
        width: w,
        matchTextDirection: isDierctional,
        color: color,
      ),
    );
  }
}
