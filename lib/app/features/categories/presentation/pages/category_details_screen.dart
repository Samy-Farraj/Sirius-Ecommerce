import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/src/components/error_screens/error_screen.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/di/services_locator.dart';
import '../bloc/categories_bloc.dart';
import '../widgets/category_details_widgets/category_details_item.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen(
      {required this.category, required this.bloc, super.key});
  CategoriesBloc bloc;
  Category category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: CustomAppBar(
          onActionPressed: () {
            //   print("Notifications tapped");
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 19.h),
                child: Text(
                  "my_categories".tr(),
                  style: textTheme.displaySmall,
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CategoryDetailsItem(
                        bloc: bloc,
                        category: category.children![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 16.h,
                      );
                    },
                    itemCount: category.children?.length ?? 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
