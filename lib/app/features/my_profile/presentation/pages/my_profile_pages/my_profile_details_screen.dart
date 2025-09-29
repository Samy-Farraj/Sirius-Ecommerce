import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sirius/app/features/auth/domain/entities/app_user.dart';
import 'package:sirius/app/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';

import '../../../../../../src/components/error_screens/error_screen.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/routing/routes.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';

class MyProfileDetailsScreen extends StatefulWidget {
  const MyProfileDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyProfileDetailsScreenState createState() => _MyProfileDetailsScreenState();
}

class _MyProfileDetailsScreenState extends State<MyProfileDetailsScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late String _selectedLang;
  late DateTime _selectedBirthDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MyProfileBloc>()..add(GetProfileInfoEvent()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: 'my_profile'.tr(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 35.h),
            child: BlocConsumer<MyProfileBloc, MyProfileState>(
              listener: (context, state) {
                // if (state is LogInAgain) {
                //   // localStorage.clearAppUser();
                //   context.go(Routes.login);
                // }
              },
              builder: (context, state) {
                if (state is ErrorProfileDetailsState) {
                  return ErrorScreen(
                    message: state.message!,
                    onRetry: () => BlocProvider.of<MyProfileBloc>(context)
                        .add(GetProfileInfoEvent()),
                  );
                } else if (state is LoadingProfileDetailsState) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 350.h),
                      child: SpinKitThreeBounce(
                        color: AppColors.primary,
                        size: 16.sp,
                      ),
                    ),
                  );
                } else if (state is DoneProfileDetailsState) {
                  _firstNameController =
                      TextEditingController(text: state.user!.name);

                  _phoneController =
                      TextEditingController(text: state.user!.phone);
                  _emailController =
                      TextEditingController(text: state.user!.email);
                  _selectedLang = state.user!.lang ?? 'ar';
                  print("state.user!.name#${state.user!.name}");
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfilePhoto(state.user!),
                        SizedBox(height: 30.h),
                        Text(
                          "my_details".tr(),
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(height: 20.h),
                        itemInfoProfile(
                            title: "full_name".tr(),
                            value: state.user!.name ?? "",
                            icon: Icons.phone),
                        Divider(
                          color: AppColors.medium,
                        ),
                        itemInfoProfile(
                            title: "email".tr(),
                            value: state.user!.email ?? "",
                            icon: Icons.phone),
                        Divider(
                          color: AppColors.medium,
                        ),
                        itemInfoProfile(
                            title: "phone".tr(),
                            value: state.user!.phone ?? "",
                            icon: Icons.phone),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 14.h, horizontal: 12.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 14.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(AppUser profile) {
    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 94.w,
                height: 94.w,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profile!.logo != null
                      ? NetworkImage(profile!.logo!)
                      : const AssetImage('assets/images/default_profile.png')
                          as ImageProvider,
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                "${profile.name}",
                style: textTheme.titleSmall,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemInfoProfile(
      {required String title, required String value, required IconData icon}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: textTheme.labelMedium!
                  .copyWith(fontSize: 14.sp, color: AppColors.grey),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                SizedBox(
                  width: 210.w,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    value,
                    style: textTheme.labelMedium!
                        .copyWith(fontSize: 14.sp, color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
