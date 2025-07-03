import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_theme.dart';

// class AppButton extends StatelessWidget {
//   const AppButton({
//     super.key,
//     required this.title,
//     this.onPressed,
//     this.bgColor,
//     this.textColor,
//     this.disabled = false,
//     this.isOutlined = false,
//     this.isLoading = false,
//   });
//
//   const AppButton.outlined({
//     super.key,
//     required this.title,
//     this.onPressed,
//     this.bgColor,
//     this.textColor,
//     this.disabled = false,
//     this.isOutlined = true,
//     this.isLoading = false,
//   });
//
//   final String title;
//   final Color? textColor;
//   final Color? bgColor;
//   final void Function()? onPressed;
//   final bool disabled;
//   final bool isOutlined;
//   final bool isLoading;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: isLoading
//             ? () {}
//             : disabled
//                 ? null
//                 : onPressed,
//         style: ButtonStyle(
//           elevation: MaterialStateProperty.all(1),
//           backgroundColor:
//               MaterialStateProperty.all(isOutlined ? AppColors.white : bgColor),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               side: BorderSide(
//                 color: disabled
//                     ? AppColors.lightest
//                     : bgColor ?? AppColors.primary,
//               ),
//             ),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 16.0.r),
//           child: isLoading
//               ? const Center(
//                   child: CircularProgressIndicator.adaptive(
//                   backgroundColor: AppColors.white,
//                 ))
//               : Text(
//                   title,
//                   style: textTheme.labelLarge!.copyWith(
//                     color: isOutlined
//                         ? textColor ?? AppColors.primary
//                         : textColor ?? AppColors.white,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.disabled = false,
    this.isOutlined = false,
    this.isLoading = false,
  });

  const AppButton.outlined({
    super.key,
    required this.title,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.disabled = false,
    this.isOutlined = true,
    this.isLoading = false,
  });

  final String title;
  final Color? textColor;
  final Color? bgColor;
  final void Function()? onPressed;
  final bool disabled;
  final bool isOutlined;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.8.sw,
      height: 44.h,
      child: GestureDetector(
        onTap: isLoading
            ? () {}
            : disabled
                ? null
                : onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: bgColor ?? AppColors.primary,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 7.h),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.white,
                    ))
                  : Text(
                      title,
                      style: textTheme.titleLarge!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isOutlined
                            ? textColor ?? AppColors.primary
                            : textColor ?? AppColors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
