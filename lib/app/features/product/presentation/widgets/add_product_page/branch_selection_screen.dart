import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius/app/features/branches/domain/entities/branch.dart';

import '../../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../../src/components/custom_button.dart';
import '../../../../../../src/components/error_screens/error_screen.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_sizes.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../color/domain/entities/my_color.dart';
import '../../../../my_profile/presentation/bloc/my_profile_bloc.dart';
import '../../pages/add_product_step_tow_screen.dart';

class BranchSelectionScreen extends StatefulWidget {
  MyProfileBloc myProfileBloc;
  @override
  _BranchSelectionScreenState createState() => _BranchSelectionScreenState();

  BranchSelectionScreen({
    required this.myProfileBloc,
  });
}

class _BranchSelectionScreenState extends State<BranchSelectionScreen> {
  Branch? _selectedBranch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.myProfileBloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'branch'.tr(),
          actionIcon: SizedBox(),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 16.h),
              Text(
                'choose_branch'.tr(),
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 16.h),
              BlocBuilder<MyProfileBloc, MyProfileState>(
                builder: (context, state) {
                  if (state is LoadingProfileDetailsState) {
                    return SpinKitThreeInOut(
                      size: 15.sp,
                      color: AppColors.primary,
                    );
                  } else if (state is DoneProfileDetailsState) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.user.branches!.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return _buildBranchCard(state.user.branches![index]);
                        },
                      ),
                    );
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
            ],
          ),
        ),
        bottomNavigationBar: _selectedBranch != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 34.h),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context, _selectedBranch);
                  },
                  text: 'add_branch'.tr(),
                  color: Colors.red,
                  isGradient: true,
                  textColor: AppColors.white,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildBranchCard(Branch branch) {
    final isSelected = _selectedBranch?.id == branch.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBranch = branch;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColors.medium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              branch.title ?? 'branch'.tr(),
              style: textTheme.labelMedium,
            ),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey[100],
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[300]!,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 18.sp,
          ),
          hintText: 'search'.tr(),
          hintStyle: textTheme.labelMedium,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
