import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sirius/app/features/auth/presentation/widgets/login_widgets/signup_button.dart';
import 'package:sirius/app/features/auth/presentation/widgets/login_widgets/top_login_header.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/validation/required_validator.dart';
import '../../../../../../src/components/custom_snack_bar/app_snackbar.dart';
import '../../../../../../src/components/custom_text_field.dart';
import '../../../../../../src/components/svg_icon_widget.dart';
import '../../../../../../src/routing/routes.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../bloc/auth_bloc.dart';
import 'easy_loading_gradient.dart';

class LoginBodyWidget extends StatelessWidget {
  LoginBodyWidget({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return Scaffold(
      body: Stack(
        children: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is GoToHomeScreenState) {
                context.pushReplacement(Routes.dashboard);
              } else if (state is ErrorLogInState) {
                AppSnackbar.show(
                    context: context,
                    message: state.errorMessage,
                    desc: "",
                    type: SnackbarType.error);
              }
              print('Login state received: ${state.runtimeType}');
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopLoginHeader(
                    title: "login_in_your_account".tr(),
                    subtitle: "please_fill_your_information".tr(),
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 352.w,
                            child: TextFieldWithTitle(
                              title: "email".tr(),
                              widget: TextFormFieldWidget(
                                prefix: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    iconTitle: 'assets/icons/message.svg',
                                    w: 16.w,
                                    h: 16.w,
                                  ),
                                ),
                                hintText: "email".tr(),
                                controller: emailController,
                                validator: RequiredValidator(),
                                prefixConstraint: BoxConstraints(
                                    maxHeight: 40.w, maxWidth: 40.w),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: 352.w,
                            child: TextFieldWithTitle(
                              title: "password".tr(),
                              widget: TextFormFieldWidget(
                                hideText: true,
                                prefix: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgIcon(
                                    iconTitle: 'assets/icons/lock.svg',
                                    w: 16.w,
                                    h: 16.w,
                                  ),
                                ),
                                secure: true,
                                hintText: "password".tr(),
                                controller: passwordController,
                                validator: RequiredValidator(),
                                prefixConstraint: BoxConstraints(
                                    maxHeight: 40.w, maxWidth: 40.w),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
          ),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return CustomButton(
                  text: 'login'.tr(),
                  color: Colors.red,
                  isGradient: true,
                  isLoading: state.loadingLogIn,
                  textColor: AppColors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(LoginEvent(
                          phone: emailController.text,
                          password: passwordController.text));
                    }
                  });
            },
          )),
    );
  }
}
