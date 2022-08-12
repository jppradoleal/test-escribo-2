import 'package:bonfire/bonfire.dart';
import 'package:pacman/entities/cookieman.dart';
import 'package:pacman/spritesheets/powerup_spritesheet.dart';

class Powerup extends GameDecoration with Sensor {
  Powerup(Vector2 position)
      : super.withAnimation(
          animation: PowerupSpriteSheet.idle,
          position: position,
          size: Vector2(16, 16),
        );

  @override
  void onContact(GameComponent component) {
    if (component is Cookieman) {
      component.triggerPowerUp(this);
    }
  }
}
