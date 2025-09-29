import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirius/src/themes/app_theme.dart';

import '../extensions/text_direction_extension.dart';
import '../themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final void Function() onPressed;
  final Widget? icon;
  final ui.TextDirection? iconDirection;
  double radius;
  bool isGradient;
  bool isLoading;
  CustomButton({
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isGradient = false,
    this.radius = 10,
    this.iconDirection,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var gradient = LinearGradient(
      colors: [AppColors.primary, AppColors.secondary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Container(
      height: 53.h,
      width: double.infinity,
      decoration: isGradient
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: gradient,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: color,
            ),
      child: MaterialButton(
        onPressed: (isLoading == false)
            ? onPressed
            : () {
                print("DSad");
              },
        child: Directionality(
          textDirection: iconDirection ?? context.textDirection,
          child: (isLoading)
              ? SpinKitThreeBounce(
                  size: 18.sp,
                  color: textColor,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                    Text(
                      text,
                      style: textTheme.labelLarge!
                          .copyWith(fontSize: 14.sp, color: textColor),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
