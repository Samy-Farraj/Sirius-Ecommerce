import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class DotPageIndicator extends StatelessWidget {
  const DotPageIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 14.h,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Stack(
        children: [
          Center(
            child: Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? AppColors.primary : Colors.transparent,
                    width: 1.0,
                  ),
                )),
          ),
          Center(
              child: Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.primary : const Color(0xFF56008D),
            ),
          )),
        ],
      ),
    );
  }
}
