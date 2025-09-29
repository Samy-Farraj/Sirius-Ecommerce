import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/product/domain/usecases/get_products_use_case.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/themes/app_sizes.dart';
import 'package:sirius/src/themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';

import '../../../../product/presentation/bloc/prodcut_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ProductBloc bloc;
  final String categoryId;
  final List<Category> categoriesChildren;

  const SearchBarWidget({
    required this.controller,
    required this.bloc,
    required this.categoryId,
    required this.categoriesChildren,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> categories =
        categoriesChildren.map((c) => c.id.toString()).toList();

    return Container(
      height: 42.h,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          bloc.add(
            GetAllProductsEvent(
              params: GetProductParams(
                page: 1,
                perPage: 30,
                search: value,
                categoryId: [categoryId, ...categories],
              ),
            ),
          );
        },
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.all(10.sp),
            child: SvgIcon(
              iconTitle: 'assets/icons/search.svg',
              w: 18.w,
              h: 18.w,
            ),
          ),
          hintText: 'search'.tr(),
          contentPadding: EdgeInsets.symmetric(vertical: 6.h),
          hintStyle: textTheme.labelMedium,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius.r),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
      ),
    );
  }
}
