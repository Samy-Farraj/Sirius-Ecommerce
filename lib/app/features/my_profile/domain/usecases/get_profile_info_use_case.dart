import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/my_profile/domain/repositories/my_profile_repository.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../../../auth/domain/entities/app_user.dart';

class GetProfileInfoUseCase implements BaseUseCase<AppUser, NoParameters> {
  final BaseMyProfileRepository repository;

  const GetProfileInfoUseCase(this.repository);

  @override
  Future<Either<Failure, AppUser>> call(NoParameters) async {
    return await repository.getProfileInfo();
  }
}
