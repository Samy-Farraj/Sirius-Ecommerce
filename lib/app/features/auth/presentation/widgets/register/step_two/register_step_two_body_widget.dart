import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../src/components/app_button.dart';
import '../../../../../../../src/components/custom_text_field.dart';
import '../../../../../../../src/components/loading_widget/loading_widget.dart';
import '../../../../../../../src/extensions/iterable_extension.dart';
import '../../../../../../../src/extensions/string_extension.dart';
import '../../../../../../../src/extensions/widget_extension.dart';
import '../../../../../../../src/routing/routes.dart';
import '../../../../../../../src/themes/app_colors.dart';
import '../../../../../../../src/themes/app_icons.dart';
import '../../../../../../../src/themes/app_images.dart';
import '../../../../../../../src/themes/app_sizes.dart';
import '../../../../../../../src/themes/app_theme.dart';
import '../../../../../../../src/validation/confirm_password_validator.dart';
import '../../../../../../../src/validation/email_validator.dart';
import '../../../../../../../src/validation/password_validator.dart';
import '../../../../../../../src/validation/required_validator.dart';
import '../../../bloc/auth_bloc.dart';

import 'dart:ui' as ui;

import '../../auth_app_bar_widget.dart';
import '../../choose_country_widget.dart';

class RegisterStepTwoBodyWidget extends StatelessWidget {
  const RegisterStepTwoBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return BlocConsumer<AuthBloc, AuthState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SuccessState) {
            // context.push(
            //   Routes.home,
            // );
            context.push(
              Routes.pageViewer,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: authAppBarWidget(
            //   title: LocaleKeys.create_new_account.tr(),
            //   leadingOnPressed: () => context.go(Routes.login),
            // ),
            body: SafeArea(
              child: LoadingWidget(
                isLoading: state.loading,
                child: Form(
                  key: bloc.formKeyForStepTwo,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.register),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(
                              sigmaX: 2.0,
                              sigmaY:
                                  2.0), // قيم sigmaX و sigmaY تحدد قوة الضبابية
                          child: Container(
                            color: AppColors.primaryShadow
                                .withOpacity(0.5), // اللون مع الشفافية
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 275.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFieldWithTitle(
                                title: LocaleKeys.password.tr(),
                                widget: TextFormFieldWidget(
                                  label: LocaleKeys.enter_your_password.tr(),
                                  controller: bloc.passwordController,
                                  hideText: true,
                                  secure: true,
                                  textStyle: textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                  validator: PasswordValidator(),
                                  prefixConstraint:
                                      AppSizes.prefixTextFieldConstraint,
                                  prefix: AppIcons.lock.svg().pSymmetric(
                                      h: AppSizes.prefixTextFieldHPadding),
                                ),
                              ),
                              TextFieldWithTitle(
                                title: LocaleKeys.confirm_password.tr(),
                                widget: TextFormFieldWidget(
                                  prefixConstraint:
                                      AppSizes.prefixTextFieldConstraint,
                                  prefix: AppIcons.lock.svg().pSymmetric(
                                      h: AppSizes.prefixTextFieldHPadding),
                                  secure: true,
                                  hideText: true,
                                  textStyle: textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                  controller: bloc.confirmPasswordController,
                                  label: LocaleKeys.confirm_your_password.tr(),
                                  validator: ConfirmPasswordValidator(
                                      bloc.passwordController),
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 60.h,
                                      child: DropdownButtonFormField<String>(
                                        style: textTheme.labelLarge?.copyWith(
                                          color: AppColors.hintText,
                                        ),
                                        value: state.gender,
                                        decoration: InputDecoration(
                                          filled: true,
                                          counterStyle: textTheme.bodyLarge!
                                              .copyWith(color: AppColors.white),
                                          fillColor: Colors.transparent,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 16),
                                          hintStyle: textTheme.labelLarge
                                              ?.copyWith(
                                                  color: AppColors.hintText),
                                          labelStyle: textTheme.labelLarge
                                              ?.copyWith(
                                                  color: AppColors.hintText),
                                          prefixIconColor: AppColors.white,
                                          suffixIconColor: AppColors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        items: ['male', 'female'].map((gender) {
                                          return DropdownMenuItem(
                                            value: gender,
                                            child: Text(gender),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          context
                                              .read<AuthBloc>()
                                              .add(SelectGenderEvent(value!));
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 60.h,
                                      child: TextFormFieldWidget(
                                        prefixConstraint:
                                            AppSizes.prefixTextFieldConstraint,
                                        textStyle:
                                            textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                        ),
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                          );
                                          if (pickedDate != null) {
                                            context.read<AuthBloc>().add(
                                                SelectBirthDateEvent(
                                                    pickedDate));
                                          }
                                        },
                                        controller: TextEditingController(
                                          text: state.birthDate != null
                                              ? "${state.birthDate!.day}/${state.birthDate!.month}/${state.birthDate!.year}"
                                              : '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // const AgreeTermsWidget(),
                              SizedBox(
                                height: 85.h,
                              ),
                              AppButton(
                                title: LocaleKeys.create_new_account.tr(),
                                // disabled: !bloc.agreeTerms,
                                textColor: AppColors.white,
                                onPressed: () {
                                  if (bloc.formKeyForStepTwo.currentState!
                                      .validate()) {
                                    bloc.add(RegisterEvent(
                                        state.birthDate, state.gender));
                                  }
                                },
                              ),
                              const Divider(),
                              TextButton(
                                onPressed: () {
                                  context.go(Routes.login);
                                },
                                child: Text(
                                  LocaleKeys.already_have_an_account.tr(),
                                  style: textTheme.labelLarge?.copyWith(
                                      color: AppColors.white,
                                      decoration: TextDecoration.underline),
                                ),
                              ).center(),
                              Container()
                            ].addSpaces(height: 18.h).toList(),
                          ).pSymmetric(h: 16.w),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class AgreeTermsWidget extends StatefulWidget {
  const AgreeTermsWidget({Key? key}) : super(key: key);

  @override
  State<AgreeTermsWidget> createState() => _AgreeTermsWidgetState();
}

class _AgreeTermsWidgetState extends State<AgreeTermsWidget> {
  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return Row(
      children: [
        Checkbox(
            value: bloc.agreeTerms,
            onChanged: (boolean) {
              setState(() {
                bloc.add(ChangeAgreeTerms());
              });
            }),
        Text(
          LocaleKeys.i_agree_to_the.tr(),
          style: textTheme.labelLarge?.copyWith(
              color: AppColors.white, decoration: TextDecoration.underline),
        ),
        TextButton(
          onPressed: () {
            //     context.push(Routes.guestTerms);
          },
          child: Text(
            LocaleKeys.terms_and_conditions.tr(),
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
