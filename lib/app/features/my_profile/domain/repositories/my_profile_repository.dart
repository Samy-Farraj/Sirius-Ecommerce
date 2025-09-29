import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/auth/domain/entities/app_user.dart';
import 'package:sirius/src/error/failure.dart';

import '../usecases/edit_profile_use_case.dart';

abstract class BaseMyProfileRepository {
  Future<Either<Failure, Unit>> deleteProfile();
  Future<Either<Failure, AppUser>> getProfileInfo();
  Future<Either<Failure, Unit>> editProfile(EditProfileParameter parameters);
}
