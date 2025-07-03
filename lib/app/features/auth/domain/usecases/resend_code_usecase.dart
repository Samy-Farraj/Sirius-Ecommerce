import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class ResendCodeUseCase extends BaseUseCase<Unit, ResendCodeParameters> {
  final BaseAuthRepository baseAuthRepository;

  ResendCodeUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, Unit>> call(
      ResendCodeParameters parameters) async {
    return await baseAuthRepository.resendCode(parameters);
  }
}

class ResendCodeParameters extends Equatable {
  final String username;

  const ResendCodeParameters({
    required this.username,
  });

  Map<String, dynamic> toMap() => {
    'username':username,
  };

  @override
  List<Object> get props => [
        username,
      ];
}
