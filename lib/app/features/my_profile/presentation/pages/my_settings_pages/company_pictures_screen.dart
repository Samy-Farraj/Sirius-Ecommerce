import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/error_screens/error_screen.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../../../src/components/svg_icon_widget.dart';
import '../../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../domain/usecases/edit_profile_use_case.dart';
import '../../bloc/my_profile_bloc.dart';

class CompanyPicturesScreen extends StatefulWidget {
  const CompanyPicturesScreen({super.key});

  @override
  State<CompanyPicturesScreen> createState() => _CompanyPicturesScreenState();
}

class _CompanyPicturesScreenState extends State<CompanyPicturesScreen> {
  File? _coverImage;
  File? _logoImage;
  bool _isCoverEdit = false;
  bool _isLogoEdit = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isCover) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isCover) {
          _coverImage = File(pickedFile.path);
        } else {
          _logoImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MyProfileBloc>()..add(GetProfileInfoEvent()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: 'company_pictures'.tr(),
        ),
        body: BlocConsumer<MyProfileBloc, MyProfileState>(
          listener: (context, state) {
            print("THE STATEE22E${state}");

            if (state is DoneProfileDetailsState) {
              print("THE STATEE22E${state}");
              LocalStorage localStorage = sl.get<LocalStorage>();
              localStorage.storeAppUser(state.user);
            }
          },
          buildWhen: (previous, current) {
            return current is LoadingProfileDetailsState ||
                current is DoneProfileDetailsState ||
                current is ErrorProfileDetailsState;
          },
          builder: (context, state) {
            if (state is DoneProfileDetailsState) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
                      child: Text(
                        'add_your_company_pictures'.tr(),
                        style: textTheme.titleMedium,
                      ),
                    ),

                    // Cover Photo Section
                    _buildImageSection(
                      title: 'cover_photo_must_be_size_800_600'.tr(),
                      image: _coverImage,
                      isCover: true,
                      isEdit: _isCoverEdit,
                      currentImage: state.user.cover.toString(),
                    ),
                    SizedBox(height: 24.h),
                    // Logo Section
                    _buildImageSection(
                      title: 'company_logo_must_be_size_300_300'.tr(),
                      image: _logoImage,
                      isCover: false,
                      isEdit: _isLogoEdit,
                      currentImage: state.user.logo.toString(),
                    ),

                    SizedBox(height: 46.h),

                    BlocConsumer<MyProfileBloc, MyProfileState>(
                      listener: (context, state) {
                        print("THE STATEE111${state}");
                        if (state is DoneEditProfileState) {
                          BlocProvider.of<MyProfileBloc>(context)
                              .add(GetProfileInfoEvent());
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          text: 'save'.tr(),
                          isLoading: state is LoadingEditProfileState,
                          color: Colors.red,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (_logoImage != null && _coverImage != null) {
                              BlocProvider.of<MyProfileBloc>(context).add(
                                  EditProfileEvent(
                                      parameters: EditProfileParameter(
                                          logo: _logoImage,
                                          cover: _coverImage)));
                            }
                            if (_logoImage != null) {
                              BlocProvider.of<MyProfileBloc>(context)
                                  .add(EditProfileEvent(
                                      parameters: EditProfileParameter(
                                logo: _logoImage,
                              )));
                            } else if (_coverImage != null) {
                              BlocProvider.of<MyProfileBloc>(context).add(
                                  EditProfileEvent(
                                      parameters: EditProfileParameter(
                                          cover: _coverImage)));
                            }
                          },
                          isGradient: true,
                        );
                      },
                    )
                  ],
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
            } else if (state is LoadingProfileDetailsState) {
              return Center(
                child: SpinKitThreeBounce(
                  size: 18.sp,
                  color: AppColors.primary,
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildImageSection({
    required String title,
    required String currentImage,
    required File? image,
    required bool isCover,
    required isEdit,
  }) {
    print("isEdit${isEdit}");
    return (isEdit == true)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _pickImage(isCover),
                child: Container(
                  height: 168.h,
                  width: 354.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              iconTitle: 'assets/icons/upload_image.svg',
                              w: 25.w,
                              h: 25.w,
                            ),
                            SizedBox(height: 9.4.h),
                            Text(
                              'upload_image'.tr(),
                              style: textTheme.labelLarge,
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                title,
                style: textTheme.labelMedium!.copyWith(fontSize: 14.sp),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 168.h,
                    width: 354.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        currentImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 15.h,
                      left: 20.w,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isCover) {
                                _isCoverEdit = true;
                              } else {
                                _isLogoEdit = true;
                              }
                            });
                          },
                          child: Icon(Icons.cancel_outlined)))
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                title,
                style: textTheme.labelMedium!.copyWith(fontSize: 14.sp),
              ),
            ],
          );
  }
}
