import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../src/core/architecture/base_usecase.dart';
import '../../../../../src/error/failure.dart';
import '../entities/app_user.dart';
import '../entities/auth_user.dart';
import '../repositories/base_auth_repository.dart';

class RegisterUseCase extends BaseUseCase<AuthUser, RegisterParameters> {
  final BaseAuthRepository baseAuthRepository;

  RegisterUseCase(this.baseAuthRepository);

  @override
  Future<Either<Failure, AuthUser>> call(RegisterParameters parameters) async {
    return await baseAuthRepository.register(parameters);
  }
}

class RegisterParameters extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String macAddress;
  final String notifcationToken;
  final String birthDate;
  final String lang;
  final String gender; //female/male
  final String profilePhoto;

  Map<String, dynamic> toMap() => {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'mac_address': macAddress,
        'notifcation_token': notifcationToken,
        'birth_date': birthDate,
        'lang': lang,
        'gender': gender,
        'profile_photo': profilePhoto,
      };

  @override
  List<Object> get props => [
        firstName,
        lastName,
        phone,
        macAddress,
        notifcationToken,
        birthDate,
        lang,
        gender,
        profilePhoto,
      ];

  const RegisterParameters({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.macAddress,
    required this.notifcationToken,
    required this.birthDate,
    required this.lang,
    required this.gender,
    required this.profilePhoto,
  });
}
