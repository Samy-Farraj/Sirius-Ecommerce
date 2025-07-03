part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SelectGenderEvent extends AuthEvent {
  final String gender;
  SelectGenderEvent(this.gender);
}

class SelectBirthDateEvent extends AuthEvent {
  final DateTime birthDate;
  SelectBirthDateEvent(this.birthDate);
}

class SelectCountryEvent extends AuthEvent {
  final String countryCode;

  const SelectCountryEvent(this.countryCode);
}

class ChangePasswordEvent extends AuthEvent {}

class ChangeAgreeTerms extends AuthEvent {}

class ForgetPasswordConfirmEvent extends AuthEvent {}

class ForgetPasswordEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {
  bool isDriver;
  LogOutEvent({required this.isDriver});
}

class RegisterEvent extends AuthEvent {
  DateTime dateTime;
  String gender;
  RegisterEvent(this.dateTime, this.gender);
}

class ResendCodeEvent extends AuthEvent {
  final String phone;

  const ResendCodeEvent({required this.phone});
}

class ResetTimerEvent extends AuthEvent {
  const ResetTimerEvent();
}

class VerifyEvent extends AuthEvent {
  final String phone;

  const VerifyEvent({required this.phone});
}

class ForgetPasswordCodeVerifyEvent extends AuthEvent {
  final String phone;

  const ForgetPasswordCodeVerifyEvent({required this.phone});
}
