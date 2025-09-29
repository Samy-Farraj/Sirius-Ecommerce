import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sirius/app/features/offers/domain/entities/offer.dart';
import 'package:sirius/app/features/offers/domain/usecases/delete_offer_by_id_use_case.dart';
import 'package:sirius/app/features/offers/domain/usecases/store_new_offer_use_case.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/usecases/get_all_offers_use_case.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final GetAllOffersUseCase getAllOffersUseCase;
  StoreNewOfferUseCase storeNewOfferUseCase;
  DeleteOfferByIdUseCase deleteOfferByIdUseCase;

  OffersBloc(
      {required this.getAllOffersUseCase,
      required this.deleteOfferByIdUseCase,
      required this.storeNewOfferUseCase})
      : super(OffersInitial()) {
    on<GetAllOffersEvent>(_onGetAllOffersEvent);
    on<DeleteOfferEvent>(_onDeleteOfferEvent);
    on<StoreNewOfferEvent>(_onStoreNewOfferEvent);
  }

  Future<void> _onStoreNewOfferEvent(
    StoreNewOfferEvent event,
    Emitter<OffersState> emit,
  ) async {
    emit(LoadingStoreNewOfferState());
    final result = await storeNewOfferUseCase.call(event.parameter);
    result.fold(
      (failure) {
        emit(ErrorStoreNewOfferState(message: failure.message));
      },
      (_) {
        emit(DoneStoreNewOfferState());
      },
    );
  }

  Future<void> _onDeleteOfferEvent(
    DeleteOfferEvent event,
    Emitter<OffersState> emit,
  ) async {
    emit(LoadingDeleteOfferState());
    final result = await deleteOfferByIdUseCase.call(event.offerId);
    result.fold(
      (failure) {
        emit(ErrorDeleteOfferState(message: failure.message));
      },
      (_) {
        emit(DoneDeleteOfferState());
      },
    );
  }

  Future<void> _onGetAllOffersEvent(
    GetAllOffersEvent event,
    Emitter<OffersState> emit,
  ) async {
    emit(LoadingOffersState());
    final result = await getAllOffersUseCase.call(NoParameters());
    result.fold(
      (failure) {
        emit(ErrorOffersState(message: failure.message));
      },
      (offers) {
        emit(DoneOffersState(offers));
      },
    );
  }
}
