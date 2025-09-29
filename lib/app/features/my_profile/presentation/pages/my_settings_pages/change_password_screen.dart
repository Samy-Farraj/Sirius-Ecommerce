import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/app/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/validation/confirm_password_validator.dart';
import '../../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../../src/components/custom_text_field.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../../../src/validation/required_validator.dart';
import '../../../domain/usecases/edit_profile_use_case.dart';

class ChangePasswordScreen extends StatelessWidget {
  late TextEditingController oldPasswordController =
      new TextEditingController();
  late TextEditingController newPasswordController =
      new TextEditingController();
  late TextEditingController confirmPasswordController =
      new TextEditingController();

  bool isLoaded = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MyProfileBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'change_password'.tr(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 39.h),
                  Text(
                    "change_you_password".tr(),
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 39.h),
                  SizedBox(
                    width: 352.w,
                    child: TextFieldWithTitle(
                      title: "old_Password".tr(),
                      widget: TextFormFieldWidget(
                        prefix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgIcon(
                            iconTitle: 'assets/icons/lock.svg',
                            w: 16.w,
                            h: 16.w,
                          ),
                        ),
                        hintText: "enter_your_password".tr(),
                        controller: oldPasswordController,
                        validator: RequiredValidator(),
                        prefixConstraint:
                            BoxConstraints(maxHeight: 40.w, maxWidth: 40.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  SizedBox(
                    width: 352.w,
                    child: TextFieldWithTitle(
                        title: "new_Password".tr(),
                        widget: TextFormFieldWidget(
                          prefixConstraint:
                              BoxConstraints(maxHeight: 40.w, maxWidth: 40.w),
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              iconTitle: 'assets/icons/lock.svg',
                              w: 16.w,
                              h: 16.w,
                            ),
                          ),
                          hintText: "enter_your_password".tr(),
                          controller: newPasswordController,
                          validator: RequiredValidator(),
                        )),
                  ),
                  SizedBox(height: 13.h),
                  SizedBox(
                    width: 352.w,
                    child: TextFieldWithTitle(
                        title: "confirm_Password".tr(),
                        widget: TextFormFieldWidget(
                          prefixConstraint:
                              BoxConstraints(maxHeight: 40.w, maxWidth: 40.w),
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              iconTitle: 'assets/icons/lock.svg',
                              w: 16.w,
                              h: 16.w,
                            ),
                          ),
                          hintText: "enter_your_password".tr(),
                          controller: confirmPasswordController,
                          validator:
                              ConfirmPasswordValidator(newPasswordController),
                        )),
                  ),
                  SizedBox(
                    height: 53.h,
                  ),
                  BlocConsumer<MyProfileBloc, MyProfileState>(
                    listener: (context, state) {
                      if (state is DoneEditProfileState) {
                        context.pop();
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state is LoadingEditProfileState,
                        text: "save".tr(),
                        color: Colors.red,
                        textColor: AppColors.white,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<MyProfileBloc>(context).add(
                                EditProfileEvent(
                                    parameters: EditProfileParameter(
                                        oldPassword: oldPasswordController.text,
                                        password: newPasswordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text)));
                          }
                        },
                        radius: 10,
                        isGradient: true,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
