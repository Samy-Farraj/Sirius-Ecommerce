import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class LogOutUseCase extends BaseUseCase<Unit, NoParameters> {
  final BaseAuthRepository baseAuthRepository;

  LogOutUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, Unit>> call(NoParameters) async {
    return await baseAuthRepository.logOut();
  }
}
