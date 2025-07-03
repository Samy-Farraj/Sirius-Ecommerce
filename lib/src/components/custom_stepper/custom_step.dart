// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStep extends StatelessWidget {
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomStep({
    Key? key,
    required this.isActive,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 8.h,
        margin: REdgeInsets.only(right: 5.w),
        decoration: BoxDecoration(
          color: isActive
              ? (activeColor ?? AppColors.primary)
              : (inactiveColor ?? AppColors.light),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
