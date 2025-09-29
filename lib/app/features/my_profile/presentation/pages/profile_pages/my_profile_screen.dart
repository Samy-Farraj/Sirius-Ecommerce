import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import '../../../../../../src/components/custom_button.dart';
import '../../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/routing/routes.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_sizes.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import 'dart:ui' as ui;

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late Locale _currentLocale;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentLocale = EasyLocalization.of(context)?.locale ?? const Locale('ar');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAccountHeader(context),
                itemFromSection("my_profile".tr(), Icons.info, () {
                  context.push(Routes.profileDetails);
                }),
                itemFromSection("my_branches".tr(), Icons.call_end_rounded, () {
                  context.push(Routes.myBranches);
                }),
                itemFromSection(
                    "my_company_specialty".tr(), Icons.question_mark, () {
                  context.push(Routes.myCompanySpecialty);
                }),
                itemFromSection("settings".tr(), Icons.file_copy, () {
                  context.push(Routes.settings);
                }),
                itemFromSection("privacy_policy".tr(), Icons.manage_accounts,
                    () {
                  context.push(Routes.manageAccount);
                }),
                GestureDetector(
                  onTap: () {
                    _showLogoutPopup(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                    margin: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.cardRadius)),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgIcon(
                          iconTitle: 'assets/icons/log_out.svg',
                          w: 22.w,
                          h: 22.w,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'logout'.tr(),
                          style: textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.red),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(children: [
                  Positioned(
                    top: 15.h,
                    left: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                  ),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Text(
                        'logout'.tr(),
                        style: textTheme.titleMedium,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 65.w,
                      height: 65.w,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'are_you_sure_want_to_logout'.tr(),
                      style: textTheme.labelLarge!.copyWith(fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'cancel'.tr(),
                            radius: 50,
                            color: AppColors.medium,
                            textColor: AppColors.black,
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Expanded(
                          child: CustomButton(
                            text: 'logout'.tr(),
                            radius: 50,
                            color: AppColors.red,
                            textColor: AppColors.white,
                            onPressed: () {
                              var bloc = sl.get<AuthBloc>();
                              bloc.add(LogOutEvent());
                              context.go(Routes.login);
                              print("تم تسجيل الخروج");
                            },
                          ),
                        )
                      ],
                    ),
                  ])
                ])));
      },
    );
  }

  Widget _buildAccountHeader(
    BuildContext context,
  ) {
    late final LocalStorage localStorage;
    localStorage = sl.get<LocalStorage>();
    return GestureDetector(
      onTap: () {
        //    context.push(Routes.userProfile);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        margin: EdgeInsets.symmetric(
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 62.w,
                  height: 62.w,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: localStorage.appUser!.logo != null
                        ? NetworkImage(localStorage.appUser!.logo.toString())
                        : const AssetImage('assets/images/default_profile.png')
                            as ImageProvider,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        localStorage.appUser!.name!,
                        style: textTheme.titleSmall,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        localStorage.appUser!.email!,
                        style: textTheme.labelSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemFromSection(String title, IconData icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style:
                  textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
            ),
            SvgIcon(iconTitle: 'assets/icons/arrow.svg')
          ],
        ),
      ),
    );
  }
}
