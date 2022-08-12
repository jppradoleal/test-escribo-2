import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class Soundboard {
  static Map<String, String> sounds = {
    'enemyHurt': 'candle-hurt-effect.wav',
    'playerHurt': 'cookieman-hurt-effect.wav',
    'powerUp': 'powerup-effect.wav',
    'bgm': 'defrini-rockabooly.mp3'
  };

  static Future initialize() async {
    if (kIsWeb) return;
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(
      sounds.values.toList(),
    );
  }

  static webGuard({
    required Function func,
  }) {
    if (kIsWeb) return;
    return func();
  }

  static playOnMobile({
    required String soundName,
    required double volume,
  }) {
    webGuard(func: () {
      FlameAudio.play(sounds[soundName]!, volume: volume);
    });
  }

  static void killPlayer() {
    playOnMobile(soundName: 'playerHurt', volume: 0.2);
  }

  static void killEnemy() {
    playOnMobile(soundName: 'enemyHurt', volume: 0.2);
  }

  static void powerUp() {
    playOnMobile(soundName: 'powerUp', volume: 0.3);
  }

  static void playBGM() {
    webGuard(func: () async {
      await FlameAudio.bgm.stop();
      FlameAudio.bgm.play(sounds['bgm']!);
    });
  }

  static stopBGM() {
    return webGuard(func: () {
      return FlameAudio.bgm.stop();
    });
  }

  static void dispose() {
    webGuard(func: () {
      FlameAudio.bgm.dispose();
    });
  }
}
