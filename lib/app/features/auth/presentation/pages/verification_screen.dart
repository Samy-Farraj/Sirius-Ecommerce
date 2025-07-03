import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../src/di/services_locator.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/verification_body_widget.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen(
      {Key? key,
      required this.phone,
      required this.fromForget,
      required this.bloc})
      : super(key: key);
  final String phone;
  final bool fromForget;
  AuthBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: listener,
        child: VerificationBodyWidget(
          phone: phone,
          fromForget: fromForget,
          bloc: bloc,
        ),
      ),
    );
  }

  void listener(BuildContext context, AuthState state) {}
}
