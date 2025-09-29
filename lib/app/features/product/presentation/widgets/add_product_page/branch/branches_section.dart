import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius/app/features/color/presentation/bloc/color_bloc.dart';
import 'package:sirius/app/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart';
import 'package:sirius/app/features/product/presentation/widgets/add_product_page/branch/branch_card.dart';
import 'package:sirius/app/features/size/presentation/bloc/color_bloc.dart';
import 'package:sirius/src/components/error_screens/error_screen.dart';
import 'package:sirius/src/themes/app_colors.dart';
import '../../../../../../../src/components/svg_icon_widget.dart';
import '../../../../../../../src/themes/app_theme.dart';
import 'colors_section.dart';

class BranchesSection extends StatelessWidget {
  final NewProductParameter product;
  final VoidCallback onAddBranch;
  final Function(int) onRemoveBranch;
  final Function(int) onAddColor;
  final Function(int, int) onRemoveColor;
  final Function(int, int) onAddSize;
  final Function(int, int, Size) onRemoveSize;
  ColorBloc colorBloc;
  SizeBloc sizeBloc;
  MyProfileBloc profileBloc;
  BranchesSection({
    Key? key,
    required this.colorBloc,
    required this.sizeBloc,
    required this.profileBloc,
    required this.product,
    required this.onAddBranch,
    required this.onRemoveBranch,
    required this.onAddColor,
    required this.onRemoveColor,
    required this.onAddSize,
    required this.onRemoveSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildBranchList(colorBloc, sizeBloc, profileBloc),
        SizedBox(height: 16),
        GestureDetector(
          onTap: onAddBranch,
          child: Row(
            children: [
              SvgIcon(
                iconTitle: 'assets/icons/folder.svg',
                w: 24.w,
                h: 24.w,
              ),
              SizedBox(width: 8.w),
              Text(
                "branch".tr(),
                style:
                    textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 11.w),
              SvgIcon(
                iconTitle: 'assets/icons/arrow_black_down.svg',
                w: 9.w,
                h: 5.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBranchList(
      ColorBloc colorBloc, SizeBloc sizeBloc, MyProfileBloc profileBloc) {
    return product.branches.asMap().entries.map((entry) {
      final index = entry.key;
      final branch = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<MyProfileBloc, MyProfileState>(
            builder: (context, state) {
              if (state is LoadingProfileDetailsState) {
                return SpinKitThreeInOut(
                  size: 15.sp,
                  color: AppColors.primary,
                );
              } else if (state is DoneProfileDetailsState) {
                return BranchCard(
                    profileBloc: profileBloc,
                    branch: branch,
                    index: index,
                    onRemove: onRemoveBranch,
                    branches: state.user.branches);
              } else if (state is ErrorProfileDetailsState) {
                return ErrorScreen(
                  message: state.message,
                  onRetry: () {
                    BlocProvider.of<MyProfileBloc>(context)
                        .add(GetProfileInfoEvent());
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: 1.w,
            height: 39.h,
            color: AppColors.medium2,
          ),
          BlocBuilder<ColorBloc, ColorState>(
            builder: (context, state) {
              if (state is LoadingColorsState) {
                return SpinKitThreeInOut(
                  size: 15.sp,
                  color: AppColors.primary,
                );
              } else if (state is DoneColorsState) {
                return ColorsSection(
                  branch: branch,
                  branchIndex: index,
                  onAddColor: onAddColor,
                  onRemoveColor: onRemoveColor,
                  onAddSize: onAddSize,
                  onRemoveSize: onRemoveSize,
                  colorBloc: colorBloc,
                  sizeBloc: sizeBloc,
                  colors: state.colors,
                );
              } else if (state is ErrorColorsState) {
                return ErrorScreen(
                  message: state.message,
                  onRetry: () {
                    BlocProvider.of<ColorBloc>(context)
                        .add(GetAllColorsEvent());
                  },
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
