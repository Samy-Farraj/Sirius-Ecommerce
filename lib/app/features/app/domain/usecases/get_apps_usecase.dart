import 'package:dartz/dartz.dart';
import 'package:osm/app/features/app/domain/entities/app.dart';
import 'package:osm/app/features/app/domain/repositories/app_repository.dart';

import '../../../../../src/error/failure.dart';

class GetAppsUsecase {
  AppRepository appRepository;
  GetAppsUsecase({
    required this.appRepository,
  });
  Future<Either<Failure, App>> call() async {
    return await appRepository.getApps();
  }
}
