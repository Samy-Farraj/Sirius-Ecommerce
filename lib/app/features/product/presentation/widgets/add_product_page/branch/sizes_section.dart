import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart';
import 'package:sirius/app/features/size/data/models/size_entity_model.dart';
import '../../../../../../../src/themes/app_colors.dart';
import '../../../../../../../src/themes/app_theme.dart';
import '../../../../../size/domain/entities/size_entity.dart';
import '../../../pages/add_product_step_tow_screen.dart';

class SizesSection extends StatelessWidget {
  final Color color;
  final int branchIndex;
  final int colorIndex;
  final List<SizeEntity> sizes;
  final Function(int, int) onAddSize;
  final Function(int, int, Size) onRemoveSize;

  const SizesSection({
    Key? key,
    required this.color,
    required this.sizes,
    required this.branchIndex,
    required this.colorIndex,
    required this.onAddSize,
    required this.onRemoveSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildSizeList(sizes),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () => onAddSize(branchIndex, colorIndex),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 16.sp,
                ),
                SizedBox(width: 2.w),
                Text(
                  "add_new_size".tr(),
                  style:
                      textTheme.labelLarge!.copyWith(color: AppColors.primary),
                )
              ],
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  List<Widget> _buildSizeList(List<SizeEntity> sizes) {
    return color.sizes.map((size) {
      final sizeEntity = sizes.firstWhere(
        (s) => s.id == size.sizeId,
        orElse: () =>
            SizeEntityModel(id: size.sizeId, name: 'Size ${size.sizeId}'),
      );

      return Container(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8.w, left: 8.w),
              width: 1.w,
              height: 60.h,
              color: AppColors.medium2,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100.w,
                    child: Text(
                      'size_item'.tr() + "${sizeEntity.name}",
                      style: textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    )),
                SizedBox(width: 11.w),
                SizedBox(
                    width: 70.w,
                    child: Text(
                      'qyt_item'.tr() + '${size.quantity}',
                      style: textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    )),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 18),
                  onPressed: () => onRemoveSize(branchIndex, colorIndex, size),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}
