import 'package:bonfire/bonfire.dart';
import 'package:pacman/entities/cookieman.dart';
import 'package:pacman/spritesheets/sugar_spritesheet.dart';

class Sugar extends GameDecoration with Sensor {
  Sugar(Vector2 position)
      : super.withAnimation(
          animation: SugarSpriteSheet.idle,
          position: position,
          size: Vector2(16, 16),
        );

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      removeFromParent();
      (component as Cookieman).collectSugar();
    }
  }
}
