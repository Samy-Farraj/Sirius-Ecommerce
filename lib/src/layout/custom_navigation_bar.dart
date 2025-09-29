import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';

import '../themes/app_colors.dart';
import 'icon_btn.dart';
import 'nav_button_model.dart';

class CustomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell child;
  const CustomNavigationBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = child.currentIndex;
    return SafeArea(
      top: false,
      child: Container(
        color: AppColors.background,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 85.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(navButtons.length, (index) {
                  // نترك مكان في المنتصف للزر الكبير (index 2) لنعالجه بالـ elevated button

                  return Expanded(
                    child: InkWell(
                      onTap: () => child.goBranch(index,
                          initialLocation: child.currentIndex == index),
                      child: _NavItem(
                        model: navButtons[index],
                        isActive: currentIndex == index,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final NavButtonModel model;
  final bool isActive;
  const _NavItem({required this.model, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            w: 24.w,
            h: 24.w,
            //size: isActive ? 26.sp : 22.sp,
            //  color: isActive ? AppColors.primary : AppColors.grey,
            iconTitle: isActive ? model.imagePath : model.standardImagePath,
          ),
          SizedBox(height: 8.h),
          isActive
              ? ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Color(0xFFFA0AF2),
                        Color(0xFF0AFAE3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: Text(
                    model.title,
                    style: textTheme.bodySmall!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Text(
                  model.title,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                )
        ],
      ),
    );
  }
}
