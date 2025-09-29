import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../filters/presentation/bloc/filters_bloc.dart';
import '../../../../filters/presentation/pages/FilterScreen.dart';
import '../../../../filters/presentation/pages/SortOptionsScreen.dart';
import '../../../../product/presentation/bloc/prodcut_bloc.dart';

class SortFilterSection extends StatelessWidget {
  final String categoryId;
  final ProductBloc productBloc;
  final FiltersBloc filtersBloc;

  const SortFilterSection({
    required this.categoryId,
    required this.productBloc,
    required this.filtersBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFA0AF2).withOpacity(0.2),
            const Color(0xFF0AFAE3).withOpacity(0.2),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SortOptionsDialog(
                    productBloc: productBloc,
                    categoryId: categoryId,
                    perPage: 50,
                  ),
                );
              },
              child: _buildActionButton('sort'.tr(), Icons.swap_vert),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => FilterScreen(
                    categoryId: categoryId,
                    productBloc: productBloc,
                    perPage: 10,
                    filtersBloc: filtersBloc,
                  ),
                );
              },
              child:
                  _buildActionButton('filter'.tr(), Icons.filter_alt_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp),
          SizedBox(width: 4.w),
          Text(text, style: textTheme.titleMedium),
        ],
      ),
    );
  }
}
