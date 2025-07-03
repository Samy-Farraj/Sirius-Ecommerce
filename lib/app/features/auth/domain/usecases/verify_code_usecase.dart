import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/auth_user.dart';
import '../repositories/base_auth_repository.dart';

class VerifyCodeUseCase extends BaseUseCase<AuthUser, VerifyCodeParameters> {
  final BaseAuthRepository baseAuthRepository;

  VerifyCodeUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, AuthUser>> call(
      VerifyCodeParameters parameters) async {
    return await baseAuthRepository.verifyCode(parameters);
  }
}

class VerifyCodeParameters extends Equatable {
  final String phone;
  final String code;
  final String notification_token;

  const VerifyCodeParameters({
    required this.phone,
    required this.code,
    required this.notification_token,
  });

  Map<String, dynamic> toMap() => {
        'phone': phone,
        'code': code,
        'notification_token': notification_token,
      };

  @override
  List<Object> get props => [
        phone,
        code,
        notification_token,
      ];
}
