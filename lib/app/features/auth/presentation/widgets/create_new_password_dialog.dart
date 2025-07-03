import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../../src/components/app_button.dart';
import '../../../../../src/components/custom_text_field.dart';
import '../../../../../src/extensions/iterable_extension.dart';
import '../../../../../src/extensions/string_extension.dart';
import '../../../../../src/extensions/widget_extension.dart';
import '../../../../../src/routing/routes.dart';
import '../../../../../src/themes/app_icons.dart';
import '../../../../../src/themes/app_sizes.dart';
import '../../../../../src/validation/confirm_password_validator.dart';
import '../../../../../src/validation/password_validator.dart';
import '../bloc/auth_bloc.dart';
import 'dialog_header_widget.dart';
import 'success_dialog.dart';

class CreateNewPasswordDialog extends StatelessWidget {
  const CreateNewPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return Dialog(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => SuccessDialog(
                title: LocaleKeys.congratulations.tr(),
                image: AppIcons.success,
                body: LocaleKeys.your_password_has_been_changed.tr(),
                buttonText: LocaleKeys.login,
                onPressed: () {
                  context.go(Routes.login);
                },
              ),
            );
          }
        },
        child: Form(
          key: bloc.createNewPasswordFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DialogHeaderWidget(
                  title: LocaleKeys.create_new_password.tr(),
                ),
                TextFieldWithTitle(
                  title: LocaleKeys.password.tr(),
                  widget: TextFormFieldWidget(
                    label: LocaleKeys.enter_your_password.tr(),
                    controller: bloc.createNewPasswordController,
                    hideText: true,
                    secure: true,
                    validator: PasswordValidator(),
                    prefixConstraint: AppSizes.prefixTextFieldConstraint,
                    prefix: AppIcons.lock
                        .svg()
                        .pSymmetric(h: AppSizes.prefixTextFieldHPadding),
                  ),
                ),
                TextFieldWithTitle(
                  title: LocaleKeys.confirm_password.tr(),
                  widget: TextFormFieldWidget(
                    prefixConstraint: AppSizes.prefixTextFieldConstraint,
                    prefix: AppIcons.lock
                        .svg()
                        .pSymmetric(h: AppSizes.prefixTextFieldHPadding),
                    secure: true,
                    hideText: true,
                    controller: bloc.createNewConfirmPasswordController,
                    label: LocaleKeys.confirm_your_password.tr(),
                    validator: ConfirmPasswordValidator(
                        bloc.createNewPasswordController),
                  ),
                ),
                AppButton(
                    title: LocaleKeys.send_code.tr(),
                    onPressed: () {
                      if (bloc.createNewPasswordFormKey.currentState!
                          .validate()) {
                        bloc.add(ForgetPasswordConfirmEvent());
                      }
                    })
              ].addSpaces(height: 16.h).toList(),
            ).pSymmetric(h: 16, v: 24),
          ),
        ),
      ),
    );
  }
}
