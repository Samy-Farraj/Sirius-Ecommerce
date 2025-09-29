import 'package:dartz/dartz.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../repositories/branch_repository.dart';

class StoreNewBranchUseCase extends BaseUseCase<Unit, NewBranchParameter> {
  final BranchesRepository repository;

  StoreNewBranchUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NewBranchParameter parameters) async {
    return await repository.storeNewBranch(parameters);
  }
}

class NewBranchParameter {
  String cityId;
  String companyId;
  String title;
  String address;
  String longitude;
  String latitude;
  String? branchId;

  NewBranchParameter({
    required this.cityId,
    required this.companyId,
    required this.title,
    required this.address,
    required this.longitude,
    required this.latitude,
    this.branchId,
  });
}
