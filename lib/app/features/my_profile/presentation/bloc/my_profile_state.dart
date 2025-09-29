part of 'my_profile_bloc.dart';

sealed class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends MyProfileState {}

class LoadingProfileDetailsState extends MyProfileState {}

class DoneProfileDetailsState extends MyProfileState {
  AppUser user;
  DoneProfileDetailsState(this.user);
  @override
  List<Object> get props => [];
}

class ErrorProfileDetailsState extends MyProfileState {
  final String message;
  ErrorProfileDetailsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingEditProfileState extends MyProfileState {}

class DoneEditProfileState extends MyProfileState {}

class ErrorEditProfileState extends MyProfileState {
  final String message;
  ErrorEditProfileState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
