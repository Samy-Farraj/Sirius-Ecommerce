import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius/src/components/error_screens/error_screen.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/di/services_locator.dart';
import '../bloc/categories_bloc.dart';
import '../widgets/categories_widgets/build_category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl.get<CategoriesBloc>()..add(GetAllCategoriesEvent()),
      child: Scaffold(
        appBar: CustomAppBar(
          showLogoImage: true,
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
                child: BlocBuilder<CategoriesBloc, CategoriesState>(
                  builder: (context, state) {
                    var bloc = context.read<CategoriesBloc>();
                    if (state is LoadingCategoriesState) {
                      return Center(
                          child: SpinKitThreeBounce(
                        size: 20.sp,
                        color: AppColors.primary,
                      ));
                    } else if (state is ErrorCategoriesState) {
                      return ErrorScreen(
                        message: state.message,
                        onRetry: () {
                          BlocProvider.of<CategoriesBloc>(context)
                              .add(GetAllCategoriesEvent());
                        },
                      );
                    } else if (state is DoneCategoriesState) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return BuildCategoryCard(
                              bloc: bloc,
                              category: state.categories[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 26.h,
                            );
                          },
                          itemCount: state.categories.length);
                    }
                    return const SizedBox(); // Initial state
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
