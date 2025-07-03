import '../../../generated/locale_keys.g.dart';
import 'custom_step.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMiniStepper extends StatelessWidget {
  final List<String> titles;
  final int currentIndex;

  const CustomMiniStepper({
    super.key,
    required this.titles,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.step_of.tr(
                  args: [
                    '${currentIndex + 1}',
                    '${titles.length}',
                  ],
                ),
                style: textTheme.bodySmall!.copyWith(color: AppColors.white),
              ),
              32.horizontalSpace,
              Expanded(
                child: SizedBox(
                  height: 10.h,
                  child: Row(
                    children: List.generate(
                      titles.length,
                      (index) => CustomStep(isActive: currentIndex >= index),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        if (currentIndex >= 0 && currentIndex < titles.length)
          Center(
            child: Text(
              titles[currentIndex],
              style: textTheme.titleLarge!.copyWith(color: AppColors.white),
            ),
          ),
      ],
    );
  }
}
