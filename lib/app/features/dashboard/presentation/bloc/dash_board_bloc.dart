import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/entities/statistics.dart';
import '../../domain/usecases/get_all_statistics_use_case.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  final GetAllStatisticsUseCase getAllStatisticsUseCase;

  DashBoardBloc({required this.getAllStatisticsUseCase})
      : super(DashBoardInitial()) {
    on<GetAllStatisticsEvent>(_onGetAllStatisticsEvent);
  }

  Future<void> _onGetAllStatisticsEvent(
    GetAllStatisticsEvent event,
    Emitter<DashBoardState> emit,
  ) async {
    emit(LoadingGetStatisticsState());

    final result = await getAllStatisticsUseCase.call(event.period);

    result.fold(
      (failure) {
        emit(ErrorGetStatisticsState(message: failure.message));
      },
      (statistics) {
        //this.statistics = statistics;
        emit(DoneGetStatisticsState(statistics));
      },
    );
  }
}
