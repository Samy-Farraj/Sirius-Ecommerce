import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/auth/presentation/widgets/login_widgets/login_body_widget.dart';
import 'package:sirius/src/components/custom_assets/custom_image_network.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../data/models/report_item_model.dart';
import '../../domain/entities/product_sale.dart';

class BuildSalesReportsList extends StatelessWidget {
  BuildSalesReportsList({required this.productSales, super.key});
  List<ProductSale> productSales;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productSales.length,
      separatorBuilder: (context, index) => Divider(
        color: AppColors.medium,
      ),
      itemBuilder: (context, index) {
        final item = productSales[index];
        return ListTile(
          leading: Text(
            '${index + 1}',
            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
          ),
          title: Row(
            children: [
              CustomImageNetwork(
                  width: 42.w,
                  height: 42.w,
                  radius: 8,
                  imageUrl: productSales[index].firstImage ?? ""),
              SizedBox(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productSales[index].title.toString(),
                    style: textTheme.labelMedium,
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          '${productSales[index].purchaseValue.toString()}' +
                              " " +
                              "s.p".tr(),
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        '${productSales[index].purchaseCount.toString()}' +
                            " " +
                            "purchases".tr(),
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
