import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sirius/app/features/categories/presentation/widgets/products_in_category_widgets/product_item.dart';
import 'package:sirius/src/components/error_screens/error_screen.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';

import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../filters/presentation/bloc/filters_bloc.dart';
import '../../../../filters/presentation/pages/FilterScreen.dart';
import '../../../../filters/presentation/pages/SortOptionsScreen.dart';
import '../../../../product/domain/usecases/get_products_use_case.dart';
import '../../../../product/presentation/bloc/prodcut_bloc.dart';
import 'items_title.dart';

class ProductGrid extends StatelessWidget {
  final ScrollController scrollController;
  final bool isLoading;
  final int perPage;
  final String categoryId;
  final List<Category> categoriesChildren;
  final Function(int newPage, bool reachedEnd) onPageUpdated;
  final VoidCallback onError;

  const ProductGrid({
    required this.scrollController,
    required this.isLoading,
    required this.perPage,
    required this.categoryId,
    required this.categoriesChildren,
    required this.onPageUpdated,
    required this.onError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          current is LoadingProductsState ||
          current is DoneProductsState ||
          current is ErrorProductsState,
      listener: (context, state) {
        if (state is DoneProductsState) {
          final page = state.product.currentPage ?? 1;
          final lastPage = state.product.lastPage ?? 1;
          onPageUpdated(page, page >= lastPage);
        } else if (state is ErrorProductsState) {
          onError();
        }
      },
      builder: (context, state) {
        if (state is DoneProductsState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemsTitle(length: state.product.data?.length),
                SizedBox(height: 16.h),
                (state.product.data?.isNotEmpty ?? false)
                    ? Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 13.w,
                            mainAxisSpacing: 16.h,
                            mainAxisExtent: 220.h + 84.h,
                          ),
                          itemCount: state.product.data?.length ?? 0,
                          itemBuilder: (context, index) => ProductItem(
                            data: state.product.data![index],
                            categoriesChild: categoriesChildren,
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 150.h),
                          child: Text(
                            'there_are_no_products'.tr() + " !",
                            style: textTheme.labelLarge,
                          ),
                        ),
                      ),
                if (isLoading)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        } else if (state is ErrorProductsState) {
          return ErrorScreen(
            message: state.message,
            onRetry: () {
              BlocProvider.of<ProductBloc>(context).add(
                GetAllProductsEvent(
                  params: GetProductParams(
                    page: 1,
                    perPage: perPage,
                    categoryId: [categoryId],
                  ),
                ),
              );
            },
          );
        } else if (state is LoadingProductsState) {
          return Center(
            child: SpinKitThreeBounce(
              size: 18.sp,
              color: AppColors.primary,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
