import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/size/domain/entities/size_entity.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/usecases/get_all_sizes_use_case.dart';

part 'color_event.dart';
part 'color_state.dart';

class SizeBloc extends Bloc<SizeEvent, SizeState> {
  final GetAllSizesUseCase getAllSizesUseCase;

  SizeBloc(this.getAllSizesUseCase) : super(SizeInitial()) {
    on<GetAllSizesEvent>(_onGetAllSizesEvent);
  }

  Future<void> _onGetAllSizesEvent(
    GetAllSizesEvent event,
    Emitter<SizeState> emit,
  ) async {
    emit(LoadingSizesState());
    final result = await getAllSizesUseCase.call(event.categoryId);
    result.fold(
      (failure) {
        emit(ErrorSizesState(message: failure.message));
      },
      (categories) {
        emit(DoneSizesState(categories));
      },
    );
  }
}
