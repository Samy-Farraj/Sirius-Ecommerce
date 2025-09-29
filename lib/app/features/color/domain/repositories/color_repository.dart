import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/src/error/failure.dart';

abstract class BaseColorRepository {
  Future<Either<Failure, List<MyColor>>> getAllColors();
}
