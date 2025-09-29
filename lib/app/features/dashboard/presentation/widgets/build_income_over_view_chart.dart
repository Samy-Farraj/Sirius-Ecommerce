import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../data/models/report_item_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BuildIncomeOverViewChart extends StatelessWidget {
  BuildIncomeOverViewChart(
      {required this.selectedPeriod, required this.data, super.key});
  List<ReportItem> data;
  String selectedPeriod;
  @override
  Widget build(BuildContext context) {
    final displayData = data.length > 7 ? data.sublist(0, 7) : data;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'income_overview'.tr(),
              style: textTheme.titleSmall!,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 7.h),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.medium, width: 1)),
              child: Text(
                _getPeriodText(context, selectedPeriod),
                style: textTheme.labelMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.medium)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250.h,
                  child: SfCartesianChart(
                    primaryYAxis: NumericAxis(
                      majorGridLines: MajorGridLines(
                        color: Color(0XFFF3F3F5),
                        width: 1,
                      ),
                    ),
                    primaryXAxis: CategoryAxis(
                      labelRotation: 60,
                    ),
                    series: <ColumnSeries>[
                      ColumnSeries<ReportItem, String>(
                        dataSource: displayData,
                        xValueMapper: (ReportItem item, _) => item.label,
                        yValueMapper: (ReportItem item, _) => item.value,
                        color: Colors.blue,
                        width: 0.3.w,
                        borderRadius: BorderRadius.circular(32),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getPeriodText(BuildContext context, String period) {
    switch (period) {
      case 'weekly':
        return 'weekly'.tr();
      case 'monthly':
        return 'monthly'.tr();
      case 'yearly':
        return 'yearly'.tr();
      default:
        return '';
    }
  }
}
