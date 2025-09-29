import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sirius/app/features/auth/presentation/pages/login_screen.dart';
import 'package:sirius/app/features/branches/domain/entities/branch.dart';
import 'package:sirius/app/features/branches/presentation/bloc/branches_bloc.dart';
import 'package:sirius/app/features/branches/presentation/bloc/branches_bloc.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/error_screens/error_screen.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/routing/routes.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';

import '../../../../../../src/di/services_locator.dart';
import '../../bloc/my_profile_bloc.dart';

class MyBranchesScreen extends StatefulWidget {
  const MyBranchesScreen({super.key});

  @override
  State<MyBranchesScreen> createState() => _MyBranchesScreenState();
}

class _MyBranchesScreenState extends State<MyBranchesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MyProfileBloc>()..add(GetProfileInfoEvent()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: 'my_branches'.tr(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 29.h, bottom: 29.h),
                child: Text(
                  'company_branches'.tr(),
                  style: textTheme.titleMedium,
                ),
              ),

              BlocBuilder<MyProfileBloc, MyProfileState>(
                buildWhen: (previous, current) {
                  return current is LoadingProfileDetailsState ||
                      current is DoneProfileDetailsState ||
                      current is ErrorProfileDetailsState;
                },
                builder: (context, state) {
                  if (state is DoneProfileDetailsState) {
                    return SizedBox(
                        height: 500.h,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return (state.user?.branches?.isEmpty ?? true)
                                  ? SizedBox(
                                      child: Center(
                                        child: Text('no_items_current'.tr()),
                                      ),
                                    )
                                  : itemCompanyBranch(
                                      context.read<MyProfileBloc>(),
                                      state.user!.branches![index],
                                      context);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox();
                            },
                            itemCount: state.user.branches?.length ?? 0));
                  } else if (state is LoadingProfileDetailsState) {
                    return Center(
                      child: SpinKitThreeBounce(
                        size: 18.sp,
                        color: AppColors.primary,
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
              //
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<MyProfileBloc, MyProfileState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: (state is DoneProfileDetailsState)
                  ? CustomButton(
                      text: 'add_new'.tr(),
                      color: Colors.red,
                      textColor: AppColors.white,
                      onPressed: () {
                        context.push(Routes.addNewBranch, extra: {
                          'branchId': state.user.id.toString(),
                          "isEdit": false,
                          "profileBloc": BlocProvider.of<MyProfileBloc>(context)
                        });
                      },
                      isGradient: true,
                    )
                  : SizedBox(),
            );
          },
        ),
      ),
    );
  }
}

Widget itemCompanyBranch(
    MyProfileBloc bloc, Branch branch, BuildContext context) {
  return BlocProvider(
    create: (context) => sl.get<BranchesBloc>(),
    child: BlocConsumer<BranchesBloc, BranchesState>(
      listener: (context, state) {
        if (state is DoneDeleteBranchState) {
          bloc.add(GetProfileInfoEvent());
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgIcon(
                  iconTitle: 'assets/icons/location.svg',
                  w: 23.w,
                  h: 23.w,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 200.w,
                        child: Text(
                          maxLines: 1,
                          branch.title!,
                          style: textTheme.labelLarge,
                        )),
                    SizedBox(
                        width: 275.w,
                        child: Text(
                          branch.address!,
                          style: textTheme.labelSmall,
                          maxLines: 2,
                        )),
                  ],
                ),
                Row(
                  children: [
                    BlocBuilder<MyProfileBloc, MyProfileState>(
                      builder: (context, state) {
                        if (state is DoneProfileDetailsState) {
                          return SvgIcon(
                            onTap: () {
                              context.push(Routes.addNewBranch, extra: {
                                'branchId': state.user.id.toString(),
                                "profileBloc":
                                    BlocProvider.of<MyProfileBloc>(context),
                                "isEdit": true,
                                "branch": branch
                              });
                            },
                            iconTitle: 'assets/icons/edit.svg',
                            w: 16.w,
                            h: 16.w,
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SvgIcon(
                      isLoading: (state is LoadingDeleteBranchState),
                      onTap: () {
                        BlocProvider.of<BranchesBloc>(context).add(
                            DeleteBranchEvent(branchId: branch.id.toString()));
                      },
                      iconTitle: 'assets/icons/delete.svg',
                      w: 16.w,
                      h: 16.w,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Divider(
              color: AppColors.medium,
            ),
            SizedBox(
              height: 24.h,
            ),
          ],
        );
      },
    ),
  );
}
