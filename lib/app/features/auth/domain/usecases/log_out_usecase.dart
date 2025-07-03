import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class LogOutUseCase extends BaseUseCase<Unit, bool> {
  final BaseAuthRepository baseAuthRepository;

  LogOutUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, Unit>> call(bool isDriver) async {
    return await baseAuthRepository.logOut(isDriver);
  }
}
