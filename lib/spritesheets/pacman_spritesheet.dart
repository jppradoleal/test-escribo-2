import 'package:bonfire/bonfire.dart';

class PacmanSpriteSheet {
  static Future<SpriteAnimation> get run => SpriteAnimation.load(
        'sprites/ball.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: run,
        runRight: run,
        runDown: run,
      );
}
