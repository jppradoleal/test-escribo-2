import 'package:bonfire/bonfire.dart';

class CoinSpriteSheet {
  static Future<SpriteAnimation> get idle => SpriteAnimation.load(
        'sprites/coin.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
}
