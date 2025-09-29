part of 'my_profile_bloc.dart';

abstract class MyProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllOffersEvent extends MyProfileEvent {}

class GetProfileInfoEvent extends MyProfileEvent {}

class EditProfileEvent extends MyProfileEvent {
  EditProfileParameter parameters;

  EditProfileEvent({
    required this.parameters,
  });
}
