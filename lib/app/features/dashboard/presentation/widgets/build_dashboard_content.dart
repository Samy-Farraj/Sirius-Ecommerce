import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_sizes.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../domain/entities/statistics.dart';
import '../bloc/dash_board_bloc.dart';
import 'build_income_over_view_chart.dart';
import 'build_sales_reports_list.dart';
import 'build_stat_card.dart';

class BuildDashboardContent extends StatefulWidget {
  BuildDashboardContent(
    this.currentContext,
    this.statistics,
    this.selectedPeriod, {
    super.key,
    required this.onPeriodChanged,
  });

  final ValueChanged<String> onPeriodChanged;

  BuildContext currentContext;
  Statistics statistics;
  String selectedPeriod;
  @override
  State<BuildDashboardContent> createState() => _BuildDashboardContentState();
}

class _BuildDashboardContentState extends State<BuildDashboardContent> {
//  String _selectedPeriod = 'weekly';

  @override
  Widget build(currentContext) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('overview'.tr(),
                  style: textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.w500)),
              _buildPeriodDropdown(context),
            ],
          ),
          SizedBox(height: 46.h),
          // Text(
          //   '${'Last updated'} | hour ago',
          //   style: TextStyle(
          //     fontSize: 14,
          //     color: Colors.grey[600],
          //   ),
          // ),

          BuildStatCard(
            // context,
            title: 'total_amount'.tr(),
            value: '${widget.statistics.totalAmount ?? 0} ${'s.p'.tr()}',
            change: widget.statistics.totalAmountDifference ?? 0,
          ),
          SizedBox(
            height: 16.h,
          ),
          BuildStatCard(
            //   context,
            title: 'total_products'.tr(),
            value: '${widget.statistics.totalProducts ?? 0}',
            change: widget.statistics.totalProductsDifference ?? 0,
          ),

          const SizedBox(height: 24),

          BuildIncomeOverViewChart(
            selectedPeriod: widget.selectedPeriod,
            data: widget.statistics.incomeOverview ?? [],
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'sales_reports'.tr(),
                style: textTheme.titleSmall!,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 7.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.medium, width: 1)),
                child: Text(
                  _getPeriodText(context, widget.selectedPeriod),
                  style: textTheme.labelMedium,
                ),
              ),
            ],
          ),
          SizedBox(height: 23.h),
          BuildSalesReportsList(
            productSales: widget.statistics.productSales ?? [],
          ),
        ],
      ),
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

  Widget _buildPeriodDropdown(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(color: AppColors.medium)),
      child: DropdownButton<String>(
        value: widget.selectedPeriod,
        underline: SizedBox(),
        style: textTheme.labelMedium,
        items: [
          DropdownMenuItem(
            value: 'weekly',
            child: Text('weekly'.tr()),
          ),
          DropdownMenuItem(
            value: 'monthly',
            child: Text('monthly'.tr()),
          ),
          DropdownMenuItem(
            value: 'yearly',
            child: Text('yearly'.tr()),
          ),
        ],
        onChanged: (String? newValue) {
          if (newValue != null) {
            widget.onPeriodChanged(newValue);
            context.read<DashBoardBloc>().add(
                  GetAllStatisticsEvent(period: newValue),
                );
          }
        },
      ),
    );
  }
}
