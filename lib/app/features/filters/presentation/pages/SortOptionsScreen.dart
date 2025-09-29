import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';

import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../product/domain/usecases/get_products_use_case.dart';
import '../../../product/presentation/bloc/prodcut_bloc.dart';

enum SortOption { highAmount, lowAmount }

class SortOptionsDialog extends StatefulWidget {
  final ProductBloc productBloc;
  final String categoryId;
  final int perPage;

  const SortOptionsDialog({
    Key? key,
    required this.productBloc,
    required this.categoryId,
    required this.perPage,
  }) : super(key: key);

  @override
  State<SortOptionsDialog> createState() => _SortOptionsDialogState();
}

class _SortOptionsDialogState extends State<SortOptionsDialog> {
  SortOption? _selectedOption;

  void _applySort() {
    if (_selectedOption != null) {
      String sortOrder =
          _selectedOption == SortOption.highAmount ? 'desc' : 'asc';

      widget.productBloc.add(
        GetAllProductsEvent(
          params: GetProductParams(
            page: 1,
            sortDirection: sortOrder,
            sortBy: 'price',
            perPage: widget.perPage,
            categoryId: [widget.categoryId],

            // sortBy: 'price',
            // sortOrder: sortOrder,
          ),
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        size: 18.sp,
                        Icons.close,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 80.w, right: 80.w),
                    child: Text(
                      'sort_by'.tr(),
                      style: textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 29.h),
            Row(
              children: [
                SvgIcon(
                  iconTitle: 'assets/icons/money.svg',
                  w: 22.w,
                  h: 22.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "sort_by_amount".tr(),
                  style: textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _buildSortOption(
              title: 'high_amount'.tr(),
              option: SortOption.highAmount,
            ),
            SizedBox(height: 12.h),
            _buildSortOption(
              title: 'low_amount'.tr(),
              option: SortOption.lowAmount,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 35.h,
              child: CustomButton(
                onPressed: _applySort,
                text: 'apply'.tr(),
                color: AppColors.red,
                textColor: AppColors.white,
                isGradient: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption({
    required String title,
    required SortOption option,
  }) {
    final isSelected = _selectedOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = option;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(color: AppColors.medium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.labelMedium,
            ),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey[100],
                borderRadius: BorderRadius.circular(2.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[300]!,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 14.sp,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
