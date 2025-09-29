// import 'package:pusher_client/pusher_client.dart';
//
// class CentralPusherManager {
//   static final CentralPusherManager _instance =
//       CentralPusherManager._internal();
//   factory CentralPusherManager() => _instance;
//
//   late PusherClient _pusher;
//   final Map<String, Channel> _channels = {};
//   final Map<String, Function(PusherEvent?)> _eventHandlers = {};
//
//   CentralPusherManager._internal() {
//     _pusher = PusherClient(
//       "6838ca262d5041a360c9",
//       PusherOptions(
//         cluster: "eu",
//       ),
//       autoConnect: false,
//     );
//     _pusher.connect();
//   }
//
//   /// ✅ الاشتراك في قناة معينة وربط إيفنتاتها
//   void subscribeToChannel(
//       String channelName, Map<String, Function(PusherEvent?)> events) {
//     if (_channels.containsKey(channelName)) {
//       print("⚠️ القناة $channelName مشترك بها بالفعل.");
//       return;
//     }
//
//     final channel = _pusher.subscribe(channelName);
//     _channels[channelName] = channel;
//
//     events.forEach((eventName, handler) {
//       _eventHandlers["$channelName:$eventName"] = handler;
//       channel.bind(eventName, handler);
//     });
//
//     print("✅ اشتركت في القناة: $channelName");
//   }
//
//   /// ❌ إلغاء الاشتراك من قناة
//   void unsubscribeFromChannel(String channelName) {
//     _channels.remove(channelName);
//     _eventHandlers.removeWhere((key, _) => key.startsWith("$channelName:"));
//     print("🚫 تم إلغاء الاشتراك في القناة: $channelName");
//   }
//
//   /// ✨ إرسال إيفنت يدويًا لقناة معينة (مثال: عند الضغط على زر)
//   void triggerEvent(
//       String channelName, String eventName, Map<String, dynamic> data) {
//     _channels[channelName]?.trigger(eventName, data);
//     print(
//         "🚀 تم إرسال إيفنت $eventName في القناة $channelName بالبيانات: $data");
//   }
//
//   /// 🔄 إعادة الاتصال عند الحاجة
//   void reconnect() {
//     _pusher.disconnect();
//     _pusher.connect();
//     print("🔄 تمت إعادة الاتصال بـ Pusher.");
//   }
// }
