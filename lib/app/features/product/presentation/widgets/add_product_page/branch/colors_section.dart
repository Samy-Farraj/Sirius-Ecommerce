import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart';
import 'package:sirius/app/features/product/presentation/widgets/add_product_page/branch/sizes_section.dart';
import '../../../../../../../src/components/error_screens/error_screen.dart';
import '../../../../../../../src/themes/app_colors.dart';
import '../../../../../../../src/themes/app_theme.dart';
import '../../../../../color/data/models/my_color_model.dart';
import '../../../../../color/presentation/bloc/color_bloc.dart';
import '../../../../../size/presentation/bloc/color_bloc.dart';
import '../../../pages/add_product_step_tow_screen.dart';
import 'ColorCard.dart';

class ColorsSection extends StatelessWidget {
  final Branch branch;
  final int branchIndex;
  final List<MyColor> colors;
  final Function(int) onAddColor;
  final Function(int, int) onRemoveColor;
  final Function(int, int) onAddSize;
  final Function(int, int, Size) onRemoveSize;
  ColorBloc colorBloc;
  SizeBloc sizeBloc;
  ColorsSection({
    Key? key,
    required this.branch,
    required this.colors,
    required this.colorBloc,
    required this.sizeBloc,
    required this.branchIndex,
    required this.onAddColor,
    required this.onRemoveColor,
    required this.onAddSize,
    required this.onRemoveSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildColorList(colors),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () => onAddColor(branchIndex),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 16.sp,
                ),
                SizedBox(width: 2.w),
                Text(
                  "add_new_color".tr(),
                  style:
                      textTheme.labelLarge!.copyWith(color: AppColors.primary),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildColorList(List<MyColor> colors) {
    return branch.colors.asMap().entries.map((colorEntry) {
      final colorIndex = colorEntry.key;
      final color = colorEntry.value;

      final myColor = colors.firstWhere(
        (c) => c.id == color.colorId,
        orElse: () =>
            MyColorModel(id: color.colorId, name: 'Color ${color.colorId}'),
      );

      return Column(
        children: [
          ColorCard(
            myColor: myColor,
            branchIndex: branchIndex,
            colorIndex: colorIndex,
            onRemove: onRemoveColor,
          ),
          BlocBuilder<SizeBloc, SizeState>(
            builder: (context, state) {
              if (state is LoadingSizesState) {
                return SpinKitThreeInOut(
                  size: 15.sp,
                  color: AppColors.primary,
                );
              } else if (state is DoneSizesState) {
                return SizesSection(
                  color: color,
                  sizes: state.sizes,
                  branchIndex: branchIndex,
                  colorIndex: colorIndex,
                  onAddSize: onAddSize,
                  onRemoveSize: onRemoveSize,
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      );
    }).toList();
  }
}
