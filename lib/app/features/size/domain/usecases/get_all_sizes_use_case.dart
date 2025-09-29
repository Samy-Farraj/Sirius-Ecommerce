import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/size/domain/entities/size_entity.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../repositories/size_repository.dart';

class GetAllSizesUseCase extends BaseUseCase<List<SizeEntity>, String> {
  final BaseSizeRepository repository;

  GetAllSizesUseCase(this.repository);

  @override
  Future<Either<Failure, List<SizeEntity>>> call(String categoryId) async {
    return await repository.getAllSizes(categoryId);
  }
}
