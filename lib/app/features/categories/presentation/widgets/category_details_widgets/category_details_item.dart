import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/app/features/auth/presentation/pages/login_screen.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:sirius/src/components/custom_assets/custom_image_network.dart';
import 'package:sirius/src/components/custom_cached_image.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/routing/routes.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_sizes.dart';
import 'package:sirius/src/themes/app_theme.dart';

class CategoryDetailsItem extends StatelessWidget {
  Category category;
  CategoriesBloc bloc;
  CategoryDetailsItem({required this.bloc, required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("category.children ${category.children}");
        print(" category.id.toString()${category.id.toString()}");
        print(" category.id.toString()${category.children.toString()}");
        print(" category.id. category.name()${category.name.toString()}");
        context.push(Routes.productsInSubCategory, extra: {
          'bloc': bloc,
          'categoriesChildren': category.children ?? [],
          "categoryId": category.id.toString()
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 8.w, right: 11.w, top: 6.h, bottom: 6.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            border: Border.all(color: AppColors.whiteBorder, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageNetwork(
                  width: 28.w,
                  height: 34.h,
                  radius: 2,
                  imageUrl: category.image ?? "",
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  category.name ?? "",
                  style: textTheme.labelMedium,
                )
              ],
            ),
            SvgIcon(iconTitle: 'assets/icons/arrow.svg'),
          ],
        ),
      ),
    );
  }
}
