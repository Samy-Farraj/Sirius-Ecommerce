import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/app/features/auth/presentation/pages/login_screen.dart';
import 'package:sirius/app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:sirius/src/routing/routes.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_sizes.dart';
import 'package:sirius/src/themes/app_theme.dart';

import '../../../../../../src/components/custom_assets/custom_image_network.dart';
import '../../../domain/entities/category.dart';

class BuildCategoryCard extends StatelessWidget {
  Category category;
  CategoriesBloc bloc;
  BuildCategoryCard({required this.bloc, required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.subCategories,
            extra: {'bloc': bloc, 'category': category});
      },
      child: Container(
        height: 160.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
        child: Stack(
          children: [
            CustomImageNetwork(
                width: double.infinity,
                fit: BoxFit.fitWidth,
                radius: AppSizes.cardRadius,
                imageUrl: category.image ?? "",
                height: 160.h),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
              height: 160.h,
              width: double.infinity,
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  category.name ?? "",
                  style:
                      textTheme.displayLarge!.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
