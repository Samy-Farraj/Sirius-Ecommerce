import 'package:equatable/equatable.dart';

import 'app_user.dart';

class AuthUser extends Equatable {
  final AppUser? company;
  final String? token;

  const AuthUser(
    this.company,
    this.token,
  );

  @override
  List<Object?> get props => [
        company,
        token,
      ];
}
