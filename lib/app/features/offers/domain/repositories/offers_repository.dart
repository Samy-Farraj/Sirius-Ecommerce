import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/offers/domain/entities/offer.dart';
import 'package:sirius/src/error/failure.dart';

import '../usecases/store_new_offer_use_case.dart';

abstract class OffersRepository {
  Future<Either<Failure, List<Offer>>> getAllOffers();
  Future<Either<Failure, Unit>> storeNewOffer(StoreNewOfferParameter parameter);
  Future<Either<Failure, Unit>> deleteOfferById(String offerId);
}
