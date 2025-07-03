import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_theme.dart';

class CustomBorderedTextField extends StatelessWidget {
  const CustomBorderedTextField({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
    required this.label,
    this.isEnable,
    this.maxLength,
    this.onChange,
    this.keyType,
    this.textDiriction,
  });

  final TextEditingController controller;
  final double width;
  final double height;
  final String label;
  final bool? isEnable;
  final int? maxLength;
  final onChange;
  final keyType;
  final textDiriction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
          textDirection: textDiriction ?? TextDirection.ltr,
          enabled: isEnable ?? true,
          maxLength: maxLength,
          onChanged: onChange,
          controller: controller,
          keyboardType: keyType ?? TextInputType.text,
          decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      BorderSide(color: AppColors.lightest, width: 1.sp)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              label: Text(
                label,
                style: textTheme.bodySmall!.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.dark,
                ),
              ))),
    );
  }
}
