import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../entities/offer.dart';
import '../repositories/offers_repository.dart';

class DeleteOfferByIdUseCase extends BaseUseCase<Unit, String> {
  final OffersRepository repository;

  DeleteOfferByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String offerId) async {
    return await repository.deleteOfferById(offerId);
  }
}
