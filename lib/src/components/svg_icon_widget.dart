import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sirius/src/themes/app_colors.dart';

class SvgIcon extends StatelessWidget {
  final String iconTitle;
  final Color? color;
  final double? h;
  final double? w;
  final bool isDierctional;
  final bool isLoading;
  final VoidCallback? onTap;

  const SvgIcon({
    super.key,
    required this.iconTitle,
    this.color,
    this.h,
    this.w,
    this.isDierctional = false,
    this.isLoading = false,
    this.onTap, // وأ
  });

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? SpinKitThreeBounce(
            size: 10.sp,
            color: AppColors.primary,
          )
        : GestureDetector(
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
