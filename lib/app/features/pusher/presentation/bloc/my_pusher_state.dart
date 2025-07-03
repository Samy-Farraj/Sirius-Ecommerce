part of 'my_pusher_bloc.dart';

abstract class MyPusherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PusherInitial extends MyPusherState {}

class PusherConnecting extends MyPusherState {}

class PusherConnected extends MyPusherState {}

class PusherDisconnected extends MyPusherState {}

class PusherMessageReceived extends MyPusherState {
  final String message;
  PusherMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}
