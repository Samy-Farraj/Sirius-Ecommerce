import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/entities/category.dart';
import '../../domain/usecases/get_all_categories_use_case.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;

  CategoriesBloc(this.getAllCategoriesUseCase) : super(CategoriesInitial()) {
    on<GetAllCategoriesEvent>(_onGetAllCategoriesEvent);
  }

  Future<void> _onGetAllCategoriesEvent(
    GetAllCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(LoadingCategoriesState());

    final result = await getAllCategoriesUseCase.call(NoParameters());

    result.fold(
      (failure) {},
      (categories) {
        emit(DoneCategoriesState(categories));
      },
    );
  }
}
