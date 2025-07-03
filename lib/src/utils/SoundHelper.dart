import 'package:audioplayers/audioplayers.dart';

class SoundHelper {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playNotificationSound() async {
    await _player.play(AssetSource('sounds/alert.mp3'));
  }
}
