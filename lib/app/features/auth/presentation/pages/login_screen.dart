import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/di/services_locator.dart';
import '../../../../../src/routing/routes.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login_body_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<AuthBloc>(),
      child: const LoginBodyWidget(),
    );
  }

  void listener(BuildContext context, AuthState state) {
    if (state is GoToVerifyState) {
      context.push(
        Routes.verifyNumber,
        extra: {
          'username':
              '${context.read<AuthBloc>().dialCode} ${context.read<AuthBloc>().phoneController.text}',
          'fromForget': false,
        },
      );
    }
  }
}
