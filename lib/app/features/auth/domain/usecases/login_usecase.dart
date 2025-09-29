import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/auth_user.dart';
import '../repositories/base_auth_repository.dart';

class LoginUseCase extends BaseUseCase<AuthUser, LoginParameters> {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, AuthUser>> call(LoginParameters parameters) async {
    return await baseAuthRepository.login(parameters);
  }
}

class LoginParameters extends Equatable {
  final String phone;
  final String password;

  const LoginParameters({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        'phone': phone,
        'password': password,
      };

  @override
  List<Object> get props => [
        phone,
        password,
      ];
}
