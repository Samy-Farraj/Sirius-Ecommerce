import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../extensions/text_direction_extension.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final void Function() onPressed;
  final Widget? icon;
  final ui.TextDirection? iconDirection;

  const CustomButton({
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.icon,
    this.iconDirection,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
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
                style: GoogleFonts.dmSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
