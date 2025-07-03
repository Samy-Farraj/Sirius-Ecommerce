import 'package:equatable/equatable.dart';

import 'app_user.dart';

class AuthUser extends Equatable {
  final AppUser? user;
  final String? token;

  const AuthUser(
    this.user,
    this.token,
  );

  @override
  List<Object?> get props => [
        user,
        token,
      ];
}
