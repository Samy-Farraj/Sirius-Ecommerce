import 'dart:async';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../../src/components/app_button.dart';
import '../../../../../src/components/custom_snack_bar/app_snackbar.dart';
import '../../../../../src/components/loading_widget/loading_widget.dart';
import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/extensions/widget_extension.dart';
import '../../../../../src/routing/routes.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_images.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../bloc/auth_bloc.dart';
import 'auth_app_bar_widget.dart';
import 'create_new_password_dialog.dart';
import 'verification_code_squares_widget.dart';

class VerificationBodyWidget extends StatefulWidget {
  VerificationBodyWidget(
      {Key? key,
      required this.phone,
      required this.fromForget,
      required this.bloc})
      : super(key: key);
  final String phone;
  final bool fromForget;
  AuthBloc bloc;
  @override
  State<VerificationBodyWidget> createState() => _VerificationBodyWidgetState();
}

class _VerificationBodyWidgetState extends State<VerificationBodyWidget> {
  late final LocalStorage localStorage;
  @override
  void initState() {
    localStorage = sl.get<LocalStorage>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future timer = Future.delayed(const Duration(seconds: 60));

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is GoToRegister) {
            print(
                "phone is ${widget.bloc.dialCode} ${widget.bloc.phoneController.text}");
            AppSnackbar.show(
                context: context,
                message: "register_complete_details".tr(),
                desc: "",
                type: SnackbarType.info);

            context.push(Routes.register, extra: {"bloc": widget.bloc});
          }
          if (state is GoToHome) {
            print("FROM HERE ${state}");
            if (localStorage.token != null) {
              if (localStorage.appUser?.isDriver == true) {
                AppSnackbar.show(
                    context: context,
                    desc: "welcome_back".tr(),
                    message: "login_successfully".tr(),
                    type: SnackbarType.success);
                context.go(Routes.driverMapScreen);
              } else {
                //  context.go(Routes.home);
                AppSnackbar.show(
                    context: context,
                    desc: "welcome_back".tr(),
                    message: "login_successfully".tr(),
                    type: SnackbarType.success);
                context.go(Routes.pageViewer);
              }

              return;
            }

            // context.go(Routes.fillCarDetails);
          }
          if (state is GoToReset) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (ctx) => BlocProvider<AuthBloc>(
                  create: (BuildContext context) => sl.get<AuthBloc>(),
                  child: const CreateNewPasswordDialog()),
            );
          }
        },
        builder: (context, state) => LoadingWidget(
          isLoading: state.loading,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  "verify_number".tr(),
                  style: textTheme.titleLarge,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "enter_otp_just_sent_to_your_number".tr(),
                      style:
                          textTheme.bodySmall?.copyWith(color: AppColors.grey),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      widget.phone,
                      textDirection: ui.TextDirection.ltr,
                      style:
                          textTheme.bodySmall?.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),

                // Text(
                //   widget.bloc.forgotPasswordPhoneController.text,
                //   style: textTheme.titleLarge?.copyWith(color: AppColors.dark),
                // ),

                SizedBox(
                  height: 52.h,
                ),
                VerificationCodeSquaresWidget(widget.phone),
                SizedBox(
                  height: 32.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return state.resendButtonLoading
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const CircularProgressIndicator(),
                        )
                      : state.startTimer
                          ? TimerWidget(
                              onTimerStop: () {
                                widget.bloc.add(const ResetTimerEvent());
                              },
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("didn_code".tr(),
                                    style: textTheme.bodySmall),
                                TextButton(
                                  onPressed: () {
                                    widget.bloc.add(
                                        ResendCodeEvent(phone: widget.phone));
                                  },
                                  child: Text(
                                    "resend".tr(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.primaryGrey,
                                    ),
                                  ),
                                ),
                              ],
                            );
                }),
                SizedBox(
                  height: 52.h,
                ),
                (widget.bloc.verifiedPhoneControllers.getCode.length <
                        widget.bloc.verifiedPhoneControllers.length)
                    ? AppButton(
                        bgColor: AppColors.secondaryGrey,
                        title: 'confirm'.tr(),
                        onPressed: () {
                          if (widget.bloc.verifiedPhoneControllers.getCode
                                  .length <
                              widget.bloc.verifiedPhoneControllers.length) {
                            return;
                          }
                          widget.bloc.add(
                            widget.fromForget
                                ? ForgetPasswordCodeVerifyEvent(
                                    phone: widget.phone)
                                : VerifyEvent(phone: widget.phone),
                          );
                        },
                      )
                    : AppButton(
                        title: 'confirm'.tr(),
                        onPressed: () {
                          if (widget.bloc.verifiedPhoneControllers.getCode
                                  .length <
                              widget.bloc.verifiedPhoneControllers.length) {
                            return;
                          }
                          widget.bloc.add(
                            widget.fromForget
                                ? ForgetPasswordCodeVerifyEvent(
                                    phone: widget.phone)
                                : VerifyEvent(phone: widget.phone),
                          );
                        },
                      ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ).center().pSymmetric(h: 16.w),
          ),
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.onTimerStop}) : super(key: key);
  final Function() onTimerStop;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  int _countdown = 180;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        stopTimer();
        widget.onTimerStop();
      }
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(LocaleKeys.resend_code_after.tr(args: [_countdown.toString()]));
  }
}
