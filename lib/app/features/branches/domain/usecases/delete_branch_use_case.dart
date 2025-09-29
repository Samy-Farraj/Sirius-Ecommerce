import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../repositories/branch_repository.dart';

class DeleteBranchUseCase extends BaseUseCase<Unit, String> {
  final BranchesRepository repository;

  DeleteBranchUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String branchId) async {
    return await repository.deleteBranch(branchId);
  }
}
