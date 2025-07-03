import 'dart:ui' as ui;

import 'package:osm/src/themes/app_colors.dart';
import 'package:osm/src/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../src/extensions/text_direction_extension.dart';

class CustomLanguageButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final void Function() onPressed;
  final Widget? icon;
  final ui.TextDirection? iconDirection;

  const CustomLanguageButton({
    required this.text,
    required this.color,
    required this.borderColor,
    required this.textColor,
    required this.onPressed,
    this.icon,
    this.iconDirection,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.primary,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Directionality(
          textDirection: iconDirection ?? context.textDirection,
          child: Row(
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
                style: textTheme.titleLarge!.copyWith(color: textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
