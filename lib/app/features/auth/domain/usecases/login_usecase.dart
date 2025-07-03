import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../repositories/base_auth_repository.dart';

class LoginUseCase extends BaseUseCase<Unit, LoginParameters> {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, Unit>> call(LoginParameters parameters) async {
    return await baseAuthRepository.login(parameters);
  }
}

class LoginParameters extends Equatable {
  final String phone;
  final bool rememberMe;

  const LoginParameters({
    required this.phone,
    required this.rememberMe,
  });

  Map<String, dynamic> toMap() => {
        'phone': phone,
      };

  @override
  List<Object> get props => [
        phone,
        rememberMe,
      ];
}
