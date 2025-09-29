import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/branches/domain/usecases/store_new_branch_use_case.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../repositories/branch_repository.dart';

class UpdateBranchUseCase extends BaseUseCase<Unit, NewBranchParameter> {
  final BranchesRepository repository;

  UpdateBranchUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NewBranchParameter parameters) async {
    return await repository.updateBranch(parameters);
  }
}
