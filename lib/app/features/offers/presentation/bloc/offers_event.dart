part of 'offers_bloc.dart';

abstract class OffersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllOffersEvent extends OffersEvent {}

class StoreNewOfferEvent extends OffersEvent {
  StoreNewOfferParameter parameter;

  StoreNewOfferEvent({
    required this.parameter,
  });
}

class DeleteOfferEvent extends OffersEvent {
  String offerId;
  DeleteOfferEvent({
    required this.offerId,
  });
}
