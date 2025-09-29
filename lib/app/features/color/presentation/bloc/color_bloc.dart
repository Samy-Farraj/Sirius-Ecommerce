import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/usecases/get_all_color_use_case.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  final GetAllColorsUseCase getAllColorsUseCase;

  ColorBloc(this.getAllColorsUseCase) : super(ColorInitial()) {
    on<GetAllColorsEvent>(_onGetAllColorsEvent);
  }

  Future<void> _onGetAllColorsEvent(
    GetAllColorsEvent event,
    Emitter<ColorState> emit,
  ) async {
    emit(LoadingColorsState());
    final result = await getAllColorsUseCase.call(NoParameters());
    result.fold(
      (failure) {
        emit(ErrorColorsState(message: failure.message));
      },
      (categories) {
        emit(DoneColorsState(categories));
      },
    );
  }
}
