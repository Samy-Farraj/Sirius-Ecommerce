import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';
import 'package:sirius/app/features/branches/domain/usecases/store_new_branch_use_case.dart';
import 'package:sirius/app/features/branches/domain/usecases/update_branch_use_case.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/usecases/delete_branch_use_case.dart';

part 'branches_event.dart';
part 'branches_state.dart';

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  final DeleteBranchUseCase deleteBranchUseCase;
  UpdateBranchUseCase updateBranchUseCase;
  StoreNewBranchUseCase storeNewBranchUseCase;
  late String areaName = "";
  late LatLng newBranchLocation;
  BranchesBloc(
      {required this.storeNewBranchUseCase,
      required this.updateBranchUseCase,
      required this.deleteBranchUseCase})
      : super(BranchesInitial()) {
    on<UpdateBranchEvent>(_onUpdateBranchEvent);
    on<AddBranchLocationEvent>(_onAddBranchLocationEvent);
    on<DeleteBranchEvent>(_onDeleteBranchEvent);
    on<StoreNewBranchEvent>(_onStoreNewBranchEvent);
  }

  Future<void> _onDeleteBranchEvent(
    DeleteBranchEvent event,
    Emitter<BranchesState> emit,
  ) async {
    emit(LoadingDeleteBranchState());
    final result = await deleteBranchUseCase.call(event.branchId);
    result.fold(
      (failure) {
        emit(ErrorDeleteBranchState(message: failure.message));
      },
      (_) {
        emit(DoneDeleteBranchState());
      },
    );
  }

  Future<void> _onStoreNewBranchEvent(
    StoreNewBranchEvent event,
    Emitter<BranchesState> emit,
  ) async {
    emit(LoadingStoreNewBranchState());
    final result = await storeNewBranchUseCase.call(event.parameter);
    result.fold(
      (failure) {
        emit(ErrorStoreNewBranchState(message: failure.message));
      },
      (_) {
        emit(DoneStoreNewBranchState());
      },
    );
  }

  Future<void> _onAddBranchLocationEvent(
    AddBranchLocationEvent event,
    Emitter<BranchesState> emit,
  ) async {
    areaName = event.areaName;
    newBranchLocation = event.location;
    emit(AddBranchLocation());
  }

  Future<void> _onUpdateBranchEvent(
    UpdateBranchEvent event,
    Emitter<BranchesState> emit,
  ) async {
    emit(LoadingUpdateBranchState());
    final result = await updateBranchUseCase.call(event.parameter);
    result.fold(
      (failure) {
        emit(ErrorUpdateBranchState(message: failure.message));
      },
      (_) {
        emit(DoneUpdateBranchState());
      },
    );
  }
}
