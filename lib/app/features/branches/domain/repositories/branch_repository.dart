import 'package:dartz/dartz.dart';
import 'package:sirius/src/error/failure.dart';

import '../usecases/store_new_branch_use_case.dart';

abstract class BranchesRepository {
  Future<Either<Failure, Unit>> updateBranch(NewBranchParameter parameters);
  Future<Either<Failure, Unit>> storeNewBranch(NewBranchParameter parameters);
  Future<Either<Failure, Unit>> deleteBranch(String branchId);
}
