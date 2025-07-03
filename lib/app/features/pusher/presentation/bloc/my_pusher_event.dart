part of 'my_pusher_bloc.dart';

abstract class MyPusherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConnectPusher extends MyPusherEvent {
  final int driverId;
  final String token;

  ConnectPusher(this.driverId, this.token);

  @override
  List<Object> get props => [driverId, token];
}

class DisconnectPusher extends MyPusherEvent {}

class NewPusherEvent extends MyPusherEvent {
  final String data;
  NewPusherEvent(this.data);

  @override
  List<Object?> get props => [data];
}
