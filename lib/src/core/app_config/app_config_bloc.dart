import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'app_config_event.dart';

part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc() : super(AppConfigInitial()) {
    on<LogInAgain>(_logInAgain);
    on<AppConfigEvent>((event, emit) {});
  }

  FutureOr<void> _logInAgain(
      LogInAgain event, Emitter<AppConfigState> emit) async {
    if (kDebugMode) {
      print('the event ');
    }
    emit(LogInAgainState());
  }
}
