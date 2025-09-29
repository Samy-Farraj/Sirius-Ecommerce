import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../entities/offer.dart';
import '../repositories/offers_repository.dart';

class StoreNewOfferUseCase extends BaseUseCase<Unit, StoreNewOfferParameter> {
  final OffersRepository repository;

  StoreNewOfferUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(StoreNewOfferParameter parameter) async {
    return await repository.storeNewOffer(parameter);
  }
}

class StoreNewOfferParameter {
  List<String> productId;
  String discountType;
  String discountAmount;
  String startDate;
  String endDate;

  StoreNewOfferParameter({
    required this.productId,
    required this.discountType,
    required this.discountAmount,
    required this.startDate,
    required this.endDate,
  });
}
