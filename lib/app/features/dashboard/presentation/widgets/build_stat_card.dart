import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_sizes.dart';
import 'package:sirius/src/themes/app_theme.dart';

import '../../../../../src/di/services_locator.dart';
import '../../data/models/report_item_model.dart';
import '../../domain/entities/statistics.dart';
import '../../domain/usecases/get_all_statistics_use_case.dart';
import '../bloc/dash_board_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BuildStatCard extends StatelessWidget {
  BuildStatCard(
      {required this.title,
      required this.value,
      required this.change,
      super.key});
  String title;
  String value;
  int change;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.medium, width: 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Color(0xFF0AFAE3),
                    Color(0xFFFA0AF2),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: Text(
                title,
                style: textTheme.bodySmall!.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: textTheme.titleMedium!),
                (change >= 0)
                    ? Text(
                        change.toString() + " " + '↑',
                        style: textTheme.labelMedium!
                            .copyWith(color: AppColors.green),
                      )
                    : Text(
                        change.toString() + " " + '↓',
                        style: textTheme.labelMedium!
                            .copyWith(color: AppColors.red),
                      ),
              ],
            ),
            SizedBox(height: 9.h),
          ],
        ),
      ),
    );
  }
}
