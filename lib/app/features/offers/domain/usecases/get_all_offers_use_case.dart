import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../entities/offer.dart';
import '../repositories/offers_repository.dart';

class GetAllOffersUseCase extends BaseUseCase<List<Offer>, NoParameters> {
  final OffersRepository repository;

  GetAllOffersUseCase(this.repository);

  @override
  Future<Either<Failure, List<Offer>>> call(Noparameters) async {
    return await repository.getAllOffers();
  }
}
