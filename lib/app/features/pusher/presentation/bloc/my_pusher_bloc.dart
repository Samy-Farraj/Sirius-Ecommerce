import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_pusher_event.dart';
part 'my_pusher_state.dart';

class MyPusherBloc extends Bloc<MyPusherEvent, MyPusherState> {
  MyPusherBloc(super.initialState);
  // late final PusherClient _pusher;
  // late Channel? _channel;
  // final String _appKey = "6838ca262d5041a360c9";
  // final String _cluster = "eu";
  // final String _authEndpoint =
  //     "https://your-server.com/pusher/auth"; // تأكد من تعديله
  //
  // MyPusherBloc() : super(PusherInitial()) {
  //   on<ConnectPusher>(_connectPusher);
  //   on<DisconnectPusher>(_disconnectPusher);
  //   on<NewPusherEvent>(_handlePusherEvent);
  // }
  //
  // void _connectPusher(ConnectPusher event, Emitter<MyPusherState> emit) async {
  //   emit(PusherConnecting());
  //
  //   _pusher = PusherClient(
  //     _appKey,
  //     PusherOptions(
  //       cluster: _cluster,
  //       auth: PusherAuth(
  //         _authEndpoint,
  //         headers: {
  //           "Authorization": "Bearer ${event.token}",
  //           "Content-Type": "application/json"
  //         },
  //       ),
  //     ),
  //     autoConnect: false,
  //   );
  //   _pusher.connect();
  //   String channelName = "private-driver.${event.driverId}";
  //   _channel = _pusher.subscribe(channelName);
  //   _channel!.bind("journey.available", (PusherEvent? event) {
  //     if (event != null) {
  //       add(NewPusherEvent(event.data.toString()));
  //     }
  //   });
  //
  //   emit(PusherConnected());
  // }
  //
  // void _disconnectPusher(DisconnectPusher event, Emitter<MyPusherState> emit) {
  //   if (_channel != null) {
  //     _pusher.unsubscribe(_channel!.name);
  //     _channel = null;
  //   }
  //   _pusher.disconnect();
  //   emit(PusherDisconnected());
  // }
  //
  // void _handlePusherEvent(NewPusherEvent event, Emitter<MyPusherState> emit) {
  //   emit(PusherMessageReceived(event.data));
  // }
  //
  // @override
  // Future<void> close() {
  //   _pusher.disconnect();
  //   return super.close();
  // }
}
