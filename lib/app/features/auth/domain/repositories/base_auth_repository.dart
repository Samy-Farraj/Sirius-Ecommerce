import 'package:dartz/dartz.dart';

import '../../../../../src/error/failure.dart';
import '../../data/models/user_id_holder_model.dart';
import '../entities/app_user.dart';

import '../entities/auth_user.dart';
import '../usecases/login_usecase.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, AuthUser>> login(LoginParameters parameters);
  Future<Either<Failure, Unit>> logOut();

}
