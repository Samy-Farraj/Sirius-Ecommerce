import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/themes/app_colors.dart';

import '../../../../../src/components/custom_assets/custom_image_network.dart';
import '../../../product/domain/entities/product.dart';

class ProductOfferItem extends StatelessWidget {
  final Product data;
  final bool isSelected;
  final VoidCallback onTap;
  final TextTheme textTheme;

  const ProductOfferItem({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.onTap,
    required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomImageNetwork(
                      fit: BoxFit.cover,
                      imageUrl: data.images!.first.url ?? "",
                      radius: 12.r,
                    ),
                  ),
                  (data.isOnSale!)
                      ? Positioned(
                          top: -1.h,
                          left: -1.w,
                          child: Container(
                            width: 40.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFF81140),
                                  Color(0xFFFF5790),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                                child: (data.activeSale!.discountType ==
                                        'percentage')
                                    ? Text(
                                        data.activeSale!.discountAmount!
                                                .toString() +
                                            '%',
                                        style: textTheme.labelLarge!
                                            .copyWith(color: AppColors.white),
                                      )
                                    : Text(
                                        data.activeSale!.discountAmount!
                                                .toString() +
                                            '-',
                                        style: textTheme.labelLarge!
                                            .copyWith(color: AppColors.white),
                                      )),
                          ),
                        )
                      : Positioned(
                          top: -1.h,
                          left: -1.w,
                          child: Container(
                            width: 40.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16)),
                            ),
                          ),
                        ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.secondary
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            : LinearGradient(
                                colors: [Colors.white, Colors.grey.shade300],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 84.h,
              padding: EdgeInsets.all(12.h),
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
                  (data.branchProducts!.isNotEmpty)
                      ? Text(
                          "${data.branchProducts?.first?.price.toString()}" +
                              " \$",
                          style: textTheme.labelSmall!.copyWith(
                              fontSize: 15.sp, color: AppColors.black),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
