part of 'auth_bloc.dart';

class AuthState extends Equatable {
  bool loadingLogIn;
  bool isLogOut;

  AuthState({
    this.loadingLogIn = false,
    this.isLogOut = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        loadingLogIn,
        isLogOut,
      ];

  AuthState copyWith({
    bool? loadingLogIn,
    bool? isLogOut,
  }) {
    return AuthState(
      loadingLogIn: loadingLogIn ?? this.loadingLogIn,
      isLogOut: isLogOut ?? this.isLogOut,
    );
  }
}

class LoadedLoginState extends AuthState {}

class GoToHomeScreenState extends AuthState {}

class ErrorLogInState extends AuthState {
  String errorMessage;
  ErrorLogInState(this.errorMessage);
}
