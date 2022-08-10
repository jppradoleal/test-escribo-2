import 'package:bonfire/bonfire.dart';

class PowerupSpriteSheet {
  static Future<SpriteAnimation> get idle => SpriteAnimation.load(
        'sprites/powerup.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
}
