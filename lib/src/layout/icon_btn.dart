import 'package:sirius/src/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/svg_icon_widget.dart';
import 'custom_paint.dart';
import 'nav_button_model.dart';

class IconBtn extends StatelessWidget {
  const IconBtn(
      {super.key, required this.btnIndex, required this.currentIndex});

  final int btnIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    bool isActive = currentIndex == btnIndex ? true : false;
    var height = isActive ? 60.0.h : 0.0;
    var width = isActive ? 50.0.w : 0.0;
    return SizedBox(
      // color: AppColors.white,
      width: 125.0.w,
      child: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: AnimatedContainer(
          //     height: height,
          //     width: width,
          //     duration: const Duration(milliseconds: 150),
          //     child: isActive
          //         ? CustomPaint(painter: ButtonNotch())
          //         : const SizedBox(),
          //   ),
          // ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    isActive
                        ? navButtons[btnIndex].standardImagePath
                        : navButtons[btnIndex].imagePath,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
                isActive
                    ? Center(
                        child: Container(
                          width: 50.w,
                          height: 40.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.primary.withOpacity(0.1)),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
