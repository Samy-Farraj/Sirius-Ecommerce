import 'package:osm/src/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/components/custom_text_field.dart';
import '../../../../../src/extensions/iterable_extension.dart';
import '../../../../../src/extensions/widget_extension.dart';
import '../../../../../src/themes/app_colors.dart';
import '../bloc/auth_bloc.dart';

class VerificationCodeSquaresWidget extends StatelessWidget {
  VerificationCodeSquaresWidget(this.phone, {Key? key}) : super(key: key);
  String phone;
  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return FittedBox(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              bloc.verifiedPhoneControllers.length,
              (index) => TextFormFieldWidget(
                    controller: bloc.verifiedPhoneControllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textStyle:
                        textTheme.titleLarge!.copyWith(color: AppColors.dark),
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          bloc.verificationCodeCurrentIndex ==
                              bloc.verifiedPhoneControllers.length - 1) {
                        bloc.add(
                          VerifyEvent(phone: phone),
                        );
                      } else {
                        if (value.isNotEmpty &&
                            bloc.verificationCodeCurrentIndex <
                                bloc.verifiedPhoneControllers.length - 1) {
                          bloc.verificationCodeCurrentIndex++;
                          FocusScope.of(context).requestFocus(
                              focusNodes[bloc.verificationCodeCurrentIndex]);
                        } else {
                          if (value.isEmpty &&
                              bloc.verificationCodeCurrentIndex > 0) {
                            bloc.verificationCodeCurrentIndex--;
                            FocusScope.of(context).requestFocus(
                                focusNodes[bloc.verificationCodeCurrentIndex]);
                          } else {
                            focusNodes.last.unfocus();
                          }
                        }
                      }
                    },
                  ).size(w: 52.w)).addSpaces(width: 16.w).toList(),
        ),
      ),
    );
  }

  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
}
