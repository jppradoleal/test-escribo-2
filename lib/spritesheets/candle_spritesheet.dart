import 'package:bonfire/bonfire.dart';

class CandleSpriteSheet {
  static Future<SpriteAnimation> get run => SpriteAnimation.load(
        'sprites/enemy.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: run,
        runRight: run,
      );
}
