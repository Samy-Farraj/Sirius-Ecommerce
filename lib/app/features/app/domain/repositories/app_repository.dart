import 'package:dartz/dartz.dart';
import 'package:osm/app/features/app/domain/entities/app.dart';

import '../../../../../src/error/failure.dart';

abstract class AppRepository {
  Future<Either<Failure, App>> getApps();
}
