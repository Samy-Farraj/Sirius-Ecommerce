import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../../../../src/error/failure.dart';
import '../repositories/color_repository.dart';

class GetAllColorsUseCase extends BaseUseCase<List<MyColor>, NoParameters> {
  final BaseColorRepository repository;

  GetAllColorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MyColor>>> call(Noparameters) async {
    return await repository.getAllColors();
  }
}
