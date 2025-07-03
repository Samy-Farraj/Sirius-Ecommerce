import 'package:osm/src/components/under_line_text_form_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../../src/components/app_button.dart';
import '../../../../../src/components/custom_text_field.dart';
import '../../../../../src/components/loading_widget/loading_widget.dart';
import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/extensions/iterable_extension.dart';
import '../../../../../src/extensions/string_extension.dart';
import '../../../../../src/extensions/widget_extension.dart';
import '../../../../../src/routing/routes.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_icons.dart';
import '../../../../../src/themes/app_images.dart';
import '../../../../../src/themes/app_sizes.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../../../src/validation/confirm_password_validator.dart';
import '../../../../../src/validation/email_validator.dart';
import '../../../../../src/validation/password_validator.dart';
import '../../../../../src/validation/required_validator.dart';
import '../bloc/auth_bloc.dart';
import 'auth_app_bar_widget.dart';
import 'choose_country_widget.dart';
import 'dart:ui' as ui;

class RegisterBodyWidget extends StatefulWidget {
  const RegisterBodyWidget({Key? key}) : super(key: key);

  @override
  State<RegisterBodyWidget> createState() => _RegisterBodyWidgetState();
}

class _RegisterBodyWidgetState extends State<RegisterBodyWidget> {
  late final LocalStorage localStorage;
  @override
  void initState() {
    // TODO: implement initState
    localStorage = sl.get<LocalStorage>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      print("THE LESSS IN REGISTER WIDGET");
      print("THE LESSS IN REGISTER WIDGET${state}");
      if (state is GoToHome) {
        if (localStorage.token != null) {
          if (localStorage.appUser?.isDriver == true) {
            context.go(Routes.driverMapScreen);
          } else {
            //    context.go(Routes.home);
            context.go(Routes.pageViewer);
          }

          return;
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        // appBar: authAppBarWidget(
        //   title: LocaleKeys.create_new_account.tr(),
        //   leadingOnPressed: () => context.go(Routes.login),
        // ),
        body: SafeArea(
          child: LoadingWidget(
            isLoading: state.loading,
            child: Form(
              key: bloc.formKeyForStepOne,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "complete_profile".tr(),
                          style: textTheme.labelLarge,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 162.w,
                            child: TextFieldWithTitle(
                              title: "first_name".tr(),
                              widget: TextFormFieldWidget(
                                hintText: "first_name".tr(),
                                controller: bloc.firstNameController,
                                validator: RequiredValidator(),
                                textStyle: textTheme.bodyLarge!,
                                prefixConstraint:
                                    AppSizes.prefixTextFieldConstraint,
                                prefix: AppIcons.user.svg().pSymmetric(
                                    h: AppSizes.prefixTextFieldHPadding),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                            width: 158.w,
                            child: TextFieldWithTitle(
                              title: "last_name".tr(),
                              widget: TextFormFieldWidget(
                                hintText: "last_name".tr(),
                                textStyle: textTheme.bodyLarge!,
                                controller: bloc.lastNameController,
                                validator: RequiredValidator(),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "birth_date".tr(),
                        style: textTheme.bodyLarge,
                      ),
                      Container(
                        child: TextFormFieldWidget(
                          prefixConstraint: AppSizes.prefixTextFieldConstraint,
                          textStyle: textTheme.bodyLarge?.copyWith(
                            color: AppColors.dark,
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now()
                                  .subtract(Duration(days: 15 * 370)),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now()
                                  .subtract(Duration(days: 15 * 370)),
                            );
                            if (pickedDate != null) {
                              context
                                  .read<AuthBloc>()
                                  .add(SelectBirthDateEvent(pickedDate));
                            }
                          },
                          controller: TextEditingController(
                            text: state.birthDate != null
                                ? "${state.birthDate!.day}/${state.birthDate!.month}/${state.birthDate!.year}"
                                : '',
                          ),
                        ),
                      ),
                      Text(
                        "gender".tr(),
                        style: textTheme.bodyLarge,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  _GenderButton(
                                    label: 'male'.tr(),
                                    icon: Icons.male,
                                    isSelected: state.gender == 'male',
                                    onTap: () => context
                                        .read<AuthBloc>()
                                        .add(SelectGenderEvent('male')),
                                  ),
                                  SizedBox(width: 16.w),
                                  _GenderButton(
                                    label: 'female'.tr(),
                                    icon: Icons.female,
                                    isSelected: state.gender == 'female',
                                    onTap: () => context
                                        .read<AuthBloc>()
                                        .add(SelectGenderEvent('female')),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const AgreeTermsWidget(),
                      SizedBox(
                        height: 85.h,
                      ),
                      Center(
                        child: AppButton(
                          title: LocaleKeys.create_new_account.tr(),
                          // disabled: !bloc.agreeTerms,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (bloc.formKeyForStepOne.currentState!
                                .validate()) {
                              bloc.add(
                                  RegisterEvent(state.birthDate, state.gender));
                            }
                          },
                        ),
                      ),

                      Container()
                    ].addSpaces(height: 16.h).toList(),
                  ).pSymmetric(h: 16.w),
                ),
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
          style: textTheme.titleLarge,
        ),
        TextButton(
          onPressed: () {
            // context.push(Routes.guestTerms);
          },
          child: Text(
            LocaleKeys.terms_and_conditions.tr(),
            style: textTheme.titleLarge?.copyWith(
                color: AppColors.primary, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

class _GenderSegment extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _GenderSegment({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isActive ? Colors.white : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}

// Widget مخصص للزر
class _GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: isSelected
                ? (label == 'male'.tr())
                    ? AppColors.primaryGrey.withOpacity(0.2)
                    : Colors.pink.withOpacity(0.2)
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? (label == 'male'.tr())
                      ? AppColors.primaryGrey.withOpacity(0.2)
                      : Colors.pink.withOpacity(0.2)
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 32.sp,
                color: isSelected ? AppColors.white : Colors.grey.shade600,
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          isSelected ? AppColors.white : Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
