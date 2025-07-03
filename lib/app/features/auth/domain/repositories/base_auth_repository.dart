import 'package:dartz/dartz.dart';

import '../../../../../src/error/failure.dart';
import '../../data/models/user_id_holder_model.dart';
import '../entities/app_user.dart';

import '../entities/auth_user.dart';
import '../usecases/login_usecase.dart';
import '../usecases/register_usecase.dart';
import '../usecases/resend_code_usecase.dart';
import '../usecases/verify_code_usecase.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, Unit>> login(LoginParameters parameters);
  Future<Either<Failure, Unit>> logOut(bool isDriver);

  Future<Either<Failure, AuthUser>> register(RegisterParameters parameters);

  Future<Either<Failure, Unit>> resendCode(ResendCodeParameters parameters);

  Future<Either<Failure, AuthUser>> verifyCode(VerifyCodeParameters parameters);
}
