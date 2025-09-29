import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/offers/domain/entities/offer.dart';
import 'package:sirius/app/features/offers/domain/usecases/store_new_offer_use_case.dart';
import '../../../../../src/components/show_message/show_message.dart';
import '../../../../../src/core/data_sources/remote/api_response.dart';
import '../../../../../src/error/exceptions.dart';
import '../../../../../src/error/failure.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../domain/repositories/offers_repository.dart';
import '../datasources/offers_remote_datasource.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OffersDataSource dataSource;

  OffersRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Offer>>> getAllOffers() async {
    try {
      ApiResponse<List<Offer>> response = await dataSource.getAllOffers();
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          showSuccessMessage(response);
          return Right(response.data!);
        }
      } else {
        showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteOfferById(String offerId) async {
    try {
      ApiResponse response = await dataSource.getAllOffers();
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          showSuccessMessage(response);
          return Right(unit);
        }
      } else {
        showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> storeNewOffer(
      StoreNewOfferParameter parameter) async {
    try {
      ApiResponse response = await dataSource.storeNewOffer(parameter);
      print('response : $response');
      if (response.hasSucceeded) {
        if (response.data == null) {
          return Left(ServerFailure(response.message ?? 'Server Failure'));
        } else {
          showSuccessMessage(response);
          return Right(unit);
        }
      } else {
        showErrorMessage(response);

        return Left(AuthenticationFailure(response.message.toString()));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(error.errorMessageModel.message));
    }
  }
}
