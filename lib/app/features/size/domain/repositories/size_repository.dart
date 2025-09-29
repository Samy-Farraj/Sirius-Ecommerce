import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/size/domain/entities/size_entity.dart';
import 'package:sirius/src/error/failure.dart';

abstract class BaseSizeRepository {
  Future<Either<Failure, List<SizeEntity>>> getAllSizes(String categoryId);
}
