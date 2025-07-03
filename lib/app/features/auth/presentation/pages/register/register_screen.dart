import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../src/di/services_locator.dart';
import '../../bloc/auth_bloc.dart';
import '../../widgets/register_body_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen(this.bloc, {Key? key}) : super(key: key);
  AuthBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: listener,
        child: const RegisterBodyWidget(),
      ),
    );
  }

  void listener(BuildContext context, AuthState state) {}
}
