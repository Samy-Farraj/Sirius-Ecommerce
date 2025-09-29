import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../main.dart';
import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/utils/constance.dart';
import '../../../../../src/utils/countries.dart';
import '../../../../../src/validation/phone_validator.dart';
import '../../domain/entities/user_id_holder.dart';

import '../../domain/usecases/log_out_usecase.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  LogOutUseCase logOutUseCase;

  AuthBloc(
    this.loginUseCase,
    this.logOutUseCase,
  ) : super(AuthState()) {
    on<LoginEvent>(_login);
    on<LogOutEvent>(_logOut);
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loadingLogIn: true));
    final result = await loginUseCase(
      LoginParameters(
        password: event.password,
        phone: event.phone,
      ),
    );
    result.fold(
      (l) {
        print("RHW RESULTI ${l}");
        emit(ErrorLogInState(l.message));
        emit(state.copyWith(loadingLogIn: false));
        if (l.message.contains('hintMesage')) {
          //emit(GoToVerifyState());
        }
      },
      (r) {
        emit(GoToHomeScreenState());
        emit(state.copyWith(loadingLogIn: false));

        // emit(GoToHome());
      },
    );
  }

  FutureOr<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loadingLogIn: true));
    final result = await logOutUseCase(NoParameters());
    result.fold(
      (l) {
        print("RHW RESULTI ${l}");
        emit(ErrorLogInState(l.message));

        if (l.message.contains('hintMesage')) {
          //emit(GoToVerifyState());
        }
      },
      (r) {
        emit(GoToHomeScreenState());
        //  emit(state.copyWith(loadingLogIn: false));

        // emit(GoToHome());
      },
    );
  }
}
