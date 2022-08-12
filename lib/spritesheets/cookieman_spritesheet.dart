import 'package:bonfire/bonfire.dart';

class CookiemanSpriteSheet {
  static Future<SpriteAnimation> get run => SpriteAnimation.load(
        'sprites/cookieman.png',
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
      );
}
