import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/themes/app_colors.dart';

import '../../../../../../src/components/error_screens/error_screen.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../categories/presentation/bloc/categories_bloc.dart';
import '../../bloc/my_profile_bloc.dart';

class MyCompanySpecialty extends StatefulWidget {
  const MyCompanySpecialty({super.key});

  @override
  State<MyCompanySpecialty> createState() => _MyCompanySpecialtyState();
}

class _MyCompanySpecialtyState extends State<MyCompanySpecialty> {
  List<Category> _companyCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'specialty_selection'.tr(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl.get<MyProfileBloc>()..add(GetProfileInfoEvent()),
          ),
          BlocProvider(
            create: (context) =>
                sl.get<CategoriesBloc>()..add(GetAllCategoriesEvent()),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 29.h, bottom: 29.h),
                child: Text(
                  'choose_your_specialty'.tr(),
                  style: textTheme.titleMedium,
                ),
              ),
              BlocConsumer<MyProfileBloc, MyProfileState>(
                listener: (context, state) {
                  if (state is DoneProfileDetailsState) {
                    setState(() {
                      _companyCategories = state.user.categories ?? [];
                    });
                  }
                },
                buildWhen: (previous, current) {
                  return current is LoadingProfileDetailsState ||
                      current is DoneProfileDetailsState ||
                      current is ErrorProfileDetailsState;
                },
                builder: (context, state) {
                  if (state is LoadingProfileDetailsState) {
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
                    return BlocBuilder<CategoriesBloc, CategoriesState>(
                      builder: (context, categoriesState) {
                        if (categoriesState is LoadingCategoriesState) {
                          return Center(
                            child: SpinKitThreeBounce(
                              size: 18.sp,
                              color: AppColors.primary,
                            ),
                          );
                        } else if (categoriesState is DoneCategoriesState) {
                          return Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                final category =
                                    categoriesState.categories[index];
                                final isCompanyCategory =
                                    _companyCategories.any((companyCat) =>
                                        companyCat.id == category.id);

                                return _buildSpecialtyCard(
                                  category,
                                  isSelected: isCompanyCategory,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox();
                              },
                              itemCount: categoriesState.categories.length,
                            ),
                          );
                        } else if (categoriesState is ErrorCategoriesState) {
                          return ErrorScreen(
                            message: categoriesState.message,
                            onRetry: () {
                              BlocProvider.of<CategoriesBloc>(context)
                                  .add(GetAllCategoriesEvent());
                            },
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtyCard(Category specialty, {required bool isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColors.medium)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            specialty.name!,
            style: textTheme.labelMedium,
          ),
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isSelected ? null : Colors.grey[100], // fallback
              borderRadius: BorderRadius.circular(2),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
