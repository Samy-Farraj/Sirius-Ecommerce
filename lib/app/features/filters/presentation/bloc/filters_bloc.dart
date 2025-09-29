import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';
import '../../domain/entities/FilterEntity.dart';
import '../../domain/usecases/get_filter_value_use_case.dart';
part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  GetFilterValueUseCase getFilterValueUseCase;
  FiltersBloc({
    required this.getFilterValueUseCase,
  }) : super(ProductInitial()) {
    on<GetFilterValueEvent>(_onGetFilterValueEvent);
  }

  Future<void> _onGetFilterValueEvent(
    GetFilterValueEvent event,
    Emitter<FiltersState> emit,
  ) async {
    emit(LoadingGetFilterProductState());
    final result = await getFilterValueUseCase.call(NoParameters());
    result.fold(
      (failure) {
        emit(ErrorGetFilterProductState(message: failure.message));
      },
      (filter) {
        emit(DoneGetFilterProductState(filter));
      },
    );
  }
}
