import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sirius/app/features/my_profile/data/repositories/my_profile_repository_impl.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../repositories/my_profile_repository.dart';

class EditProfileUseCase implements BaseUseCase<Unit, EditProfileParameter> {
  final BaseMyProfileRepository repository;

  const EditProfileUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(EditProfileParameter parameters) async {
    return await repository.editProfile(parameters);
  }
}

class EditProfileParameter {
  String? name;
  String? description;
  String? password;
  String? confirmPassword;
  String? oldPassword;
  String? email;
  String? phone;
  String? birthDate;
  String? lang;
  String? mode;
  File? logo;
  File? cover;
  int? muteNotification;

  EditProfileParameter({
    this.name,
    this.password,
    this.confirmPassword,
    this.oldPassword,
    this.description,
    this.email,
    this.phone,
    this.birthDate,
    this.lang,
    this.mode,
    this.logo,
    this.cover,
    this.muteNotification,
  });
}
