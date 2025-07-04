import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../../src/components/app_button.dart';
import '../../../../../src/components/custom_text_field.dart';
import '../../../../../src/components/loading_widget/loading_widget.dart';
import '../../../../../src/components/under_line_text_form_field_widget.dart';
import '../../../../../src/extensions/iterable_extension.dart';
import '../../../../../src/extensions/string_extension.dart';
import '../../../../../src/extensions/widget_extension.dart';
import '../../../../../src/routing/routes.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_icons.dart';
import '../../../../../src/themes/app_images.dart';
import '../../../../../src/themes/app_sizes.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../../../src/validation/password_validator.dart';
import '../bloc/auth_bloc.dart';
import 'auth_app_bar_widget.dart';
import 'choose_country_widget.dart';
import 'forgot_password_dialog.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return Scaffold(
      // appBar: authAppBarWidget(
      //   title: LocaleKeys.login.tr(),
      //   leadingOnPressed: () {
      //     context.pop();
      //   },
      // ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            print("STATE NEW : ${state}");
            if (state is GoToHome) {
              //context.go(Routes.home);
              context.go(Routes.pageViewer);
              // context.go(Routes.fillCarDetails);
            } else if (state is GoToVerifyState) {
              context.push(
                Routes.verifyNumber,
                extra: {
                  'bloc': bloc,
                  'username':
                      '${context.read<AuthBloc>().dialCode} ${context.read<AuthBloc>().phoneController.text}',
                  'fromForget': false,
                },
              );
            }
          },
          builder: (context, state) {
            return LoadingWidget(
              isLoading: state.loading || state is GoToHome,
              child: Form(
                key: bloc.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.logo),
                    SizedBox(
                      height: 52.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 255.w,
                          child: BlocSelector<AuthBloc, AuthState, String>(
                            selector: (state) => state.countryCode,
                            builder: (context, state) {
                              return FocusScope(
                                child: TextFieldWithTitle(
                                  title: LocaleKeys.phone_number.tr(),
                                  widget: UnderLineTextFormFieldWidget(
                                    keyboardType: TextInputType.number,
                                    maxLength: 9,
                                    textStyle: textTheme.bodyLarge?.copyWith(
                                      color: AppColors.dark,
                                    ),
                                    suffixIcon: BlocSelector<AuthBloc,
                                        AuthState, String>(
                                      selector: (state) => state.countryCode,
                                      builder: (context, state) {
                                        return Directionality(
                                            textDirection: ui.TextDirection.ltr,
                                            child: ChooseCountryWidget());
                                      },
                                    ),
                                    textDirection: ui.TextDirection.ltr,
                                    controller: bloc.phoneController,
                                    validator: bloc.phoneValidator,
                                    label: bloc.phoneLabel,
                                  ),
                                ),
                              );
                              ;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 52.h,
                    ),
                    AppButton(
                      title: LocaleKeys.login.tr(),
                      onPressed: () {
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(LoginEvent());
                        }
                      },
                    ),
                  ].addSpaces(height: 16.h).toList(),
                ).pSymmetric(h: 40.w),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RememberMeWidget extends StatefulWidget {
  const RememberMeWidget({Key? key}) : super(key: key);

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return Row(
      children: [
        Checkbox(
            value: bloc.rememberMe,
            onChanged: (boolean) {
              setState(() {
                bloc.rememberMe = !bloc.rememberMe;
              });
            }),
        Text(
          LocaleKeys.remember_me.tr(),
          style: textTheme.titleLarge,
        ),
      ],
    );
  }
}
