// import 'dart:developer';
// import 'package:fitnet/features/player_view/group_challenges/data/models/message_model.dart';
// import 'package:fitnet/features/player_view/group_challenges/presentation/bloc/challenges_bloc.dart';
// import 'package:fitnet/features/player_view/group_challenges/presentation/widgets/chat_bubble.dart';
// import 'package:fitnet/features/player_view/group_challenges/presentation/widgets/chat_input_field.dart';
// import 'package:fitnet/style/style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:convert';
// import 'package:pusher_client/pusher_client.dart';
//
// class ChatScreen extends StatefulWidget {
//   final int challengeId;
//   final ChallengesBloc bloc;
//   const ChatScreen({super.key, required this.challengeId, required this.bloc});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   List<Map<String, dynamic>> messages = [];
//   TextEditingController controller = TextEditingController();
//   late PusherClient pusher;
//   late Channel channel;
//   ScrollController scrollController = ScrollController();
//
//   /// Scroll to the bottom of the list
//   void scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (scrollController.hasClients) {
//         scrollController.animateTo(
//           scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     setupPusher();
//     widget.bloc.add(GetMessagesEvent(id: widget.challengeId));
//   }
//
//   @override
//   void dispose() {
//     pusher.unsubscribe("group-challenge.${widget.challengeId}");
//     pusher.disconnect();
//     super.dispose();
//   }
//
//   void setupPusher() {
//     pusher =
//         PusherClient("appkey", PusherOptions(cluster: "eu"), autoConnect: true);
//
//     channel = pusher.subscribe("group-challenge.${widget.challengeId}");
//
//     channel.bind("message-sent", (event) {
//       if (event != null && event.data != null) {
//         log("Received event: ${event.data}");
//         widget.bloc.add(AddMessageEvent(
//             message: MessageModel.fromJson(json.decode(event.data!))));
//       } else {
//         log("Received empty event data");
//       }
//     });
//
//     pusher.onConnectionStateChange((state) {
//       log("Pusher connection state: ${state?.currentState}");
//     });
//     pusher.onConnectionError((error) {
//       log("Pusher connection error: ${error?.message}");
//     });
//     pusher.connect();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: widget.bloc,
//       child: Scaffold(
//         body: BlocConsumer<ChallengesBloc, ChallengesState>(
//           listener: (context, state) {
//             if (state.status == ChallengesStatus.messageAdded ||
//                 state.status == ChallengesStatus.success) {
//               scrollToBottom();
//             }
//           },
//           builder: (context, state) => state.status ==
//                   ChallengesStatus.loadingMessages
//               ? Center(child: CircularProgressIndicator(color: newPrimaryColor))
//               : Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         padding: EdgeInsets.zero,
//                         controller: scrollController,
//                         itemCount: state.messages.length,
//                         itemBuilder: (context, index) {
//                           return ChatBubble(
//                             message: state.messages[index],
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ChatInputField(
//                         bloc: widget.bloc,
//                         onSend: (value) {
//                           widget.bloc.add(SendMessageEvent(
//                               message: value, id: widget.challengeId));
//                           controller.clear();
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
