part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String countryCode;
  bool loading;
  bool isLogOut;
  final bool successRegister;
  final bool resendButtonLoading;
  final bool startTimer;
  final bool agreeTerms;
  final String gender;
  final DateTime birthDate;

  AuthState({
    this.countryCode = '',
    this.loading = false,
    this.isLogOut = false,
    this.gender = "male",
    DateTime? birthDate,
    this.successRegister = false,
    this.resendButtonLoading = false,
    this.startTimer = false,
    this.agreeTerms = false,
  }) : birthDate =
            birthDate ?? DateTime.now().subtract(Duration(days: 15 * 370));

  @override
  // TODO: implement props
  List<Object?> get props => [
        countryCode,
        isLogOut,
        resendButtonLoading,
        loading,
        gender,
        birthDate,
        startTimer,
        successRegister,
        agreeTerms,
      ];

  AuthState copyWith({
    String? countryCode,
    String? gender,
    DateTime? birthDate,
    bool? loading,
    bool? isLogOut,
    bool? successRegister,
    bool? resendButtonLoading,
    bool? startTimer,
    bool? agreeTerms,
  }) {
    return AuthState(
      countryCode: countryCode ?? this.countryCode,
      loading: loading ?? this.loading,
      isLogOut: isLogOut ?? this.isLogOut,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      successRegister: successRegister ?? this.successRegister,
      resendButtonLoading: resendButtonLoading ?? this.resendButtonLoading,
      startTimer: startTimer ?? this.startTimer,
      agreeTerms: agreeTerms ?? this.agreeTerms,
    );
  }
}

class SuccessState extends AuthState {}

class GoToHome extends AuthState {}

class LogOutState extends AuthState {}

class GoToRegister extends AuthState {}

class GoToReset extends AuthState {}

class GoToVerifyState extends AuthState {}
