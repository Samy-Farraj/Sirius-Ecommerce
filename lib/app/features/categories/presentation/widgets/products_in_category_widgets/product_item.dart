import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import 'package:sirius/app/features/product/domain/entities/product.dart';
import 'package:sirius/app/features/product/presentation/bloc/prodcut_bloc.dart';
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart'
    as productTemplate;
import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius/src/routing/routes.dart';
import 'package:sirius/src/themes/app_theme.dart';

import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../filters/presentation/bloc/filters_bloc.dart';
import '../../../../filters/presentation/pages/FilterScreen.dart';
import '../../../../filters/presentation/pages/SortOptionsScreen.dart';
import '../../../../product/presentation/bloc/prodcut_bloc.dart';
import '../ProductImageSlider.dart';

class ProductItem extends StatelessWidget {
  final Product data;
  final List<Category> categoriesChild;

  const ProductItem({
    required this.data,
    required this.categoriesChild,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(context),
          _buildInfoSection(),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Container(
      height: 220.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: ProductImageSlider(
              imageUrls: data.images!.map((e) => e.url ?? "").toList(),
            ),
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () => _editProduct(context),
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: SvgIcon(iconTitle: 'assets/icons/edit_grey.svg'),
              ),
            ),
          ),
          if (data.isOnSale!) _buildDiscountTag() else SizedBox(),
        ],
      ),
    );
  }

  Widget _buildDiscountTag() {
    return Positioned(
      top: -1.h,
      left: -1.w,
      child: Container(
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
          gradient: LinearGradient(
            colors: [Color(0xFFF81140), Color(0xFFFF5790)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: data.activeSale?.discountType == 'percentage'
              ? Text(
                  '${data.activeSale!.discountAmount}%',
                  style: textTheme.labelLarge!.copyWith(color: AppColors.white),
                )
              : SizedBox(),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      height: 84.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.name ?? "", style: textTheme.labelLarge),
          Text(
            data.description ?? "",
            style: textTheme.labelSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (data.branchProducts!.isNotEmpty)
            Text(
              "${data.branchProducts?.first?.price.toString()} \$",
              style: textTheme.labelSmall!.copyWith(
                fontSize: 15.sp,
                color: AppColors.black,
              ),
            ),
        ],
      ),
    );
  }

  void _editProduct(BuildContext context) {
    List<int> idsCategories =
        data.categories?.map((c) => c.id ?? 0).toList() ?? [];

    List<productTemplate.Branch> oldBranches = [];
    for (int i = 0; i < data.branchProducts!.length; i++) {
      final branch = data.branchProducts![i];
      final branchData = productTemplate.Branch(
        branchId: branch.branchId!,
        price: branch.price!,
        colors: [],
      );
      for (int j = 0; j < branch.productStorage!.length; j++) {
        final storage = branch.productStorage![j];
        branchData.colors.add(
          productTemplate.Color(
            colorId: storage.color!.id!,
            sizes: [
              productTemplate.Size(
                sizeId: storage.sizeId!,
                quantity: storage.quantity!,
              )
            ],
          ),
        );
      }
      oldBranches.add(branchData);
    }

    log("Editing product ${data.id}");
    context.push(Routes.addProduct, extra: {
      'oldBloc': BlocProvider.of<ProductBloc>(context),
      'categoryId': data.categories!.last.id.toString(),
      'isEdit': true,
      'productToEdit': productTemplate.NewProductParameter(
        oldImageUrl: data.images,
        productId: data.id,
        companyId: data.companyId!,
        price: data.branchProducts!.first.price!,
        name: data.name!,
        description: data.description!,
        gender: data.gender!,
        isOnSale: 0,
        isReplaceable: 0,
        isRefundable: 0,
        points: 0,
        categories: idsCategories,
        branches: oldBranches,
        images: [],
      ),
      'categoriesChildren': categoriesChild,
    });
  }
}
