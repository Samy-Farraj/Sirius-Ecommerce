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
import '../bloc/auth_bloc.dart';
import 'choose_country_widget.dart';
import 'dialog_header_widget.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return Dialog(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is SuccessState) {
            context.push(Routes.verifyNumber, extra: {
              'bloc': bloc,
              'username':
                  '${bloc.dialCode} ${bloc.forgotPasswordPhoneController.text}',
              'fromForget': true,
            });
          }
        },
        child: Form(
          key: bloc.forgotPasswordFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogHeaderWidget(
                title: LocaleKeys.forgot_password.tr().removeLast(),
              ),
              BlocSelector<AuthBloc, AuthState, String>(
                selector: (state) => state.countryCode,
                builder: (context, state) {
                  return TextFieldWithTitle(
                    title: LocaleKeys.phone_number.tr(),
                    widget: TextFormFieldWidget(
                      keyboardType: TextInputType.number,
                      controller: bloc.forgotPasswordPhoneController,
                      validator: bloc.phoneValidator,
                      maxLength: 9,
                      label: bloc.phoneLabel,
                      prefix: const ChooseCountryWidget(),
                    ),
                  );
                },
              ),
              AppButton(
                  title: LocaleKeys.send_code.tr(),
                  onPressed: () {
                    if (bloc.forgotPasswordFormKey.currentState!.validate()) {
                      bloc.add(ForgetPasswordEvent());
                    }
                  })
            ].addSpaces(height: 16.h).toList(),
          ).pSymmetric(h: 16, v: 24),
        ),
      ),
    );
  }
}
