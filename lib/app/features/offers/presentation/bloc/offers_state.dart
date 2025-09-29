part of 'offers_bloc.dart';

sealed class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object> get props => [];
}

class OffersInitial extends OffersState {}

class LoadingOffersState extends OffersState {}

class DoneOffersState extends OffersState {
  List<Offer> offers;
  DoneOffersState(this.offers);
  @override
  List<Object> get props => [offers];
}

class ErrorOffersState extends OffersState {
  final String message;
  ErrorOffersState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingStoreNewOfferState extends OffersState {}

class DoneStoreNewOfferState extends OffersState {}

class ErrorStoreNewOfferState extends OffersState {
  final String message;
  ErrorStoreNewOfferState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingDeleteOfferState extends OffersState {}

class DoneDeleteOfferState extends OffersState {}

class ErrorDeleteOfferState extends OffersState {
  final String message;
  ErrorDeleteOfferState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
