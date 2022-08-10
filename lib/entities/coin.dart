import 'package:bonfire/bonfire.dart';
import 'package:pacman/entities/player.dart';
import 'package:pacman/spritesheets/coin_spritesheet.dart';

class Coin extends GameDecoration with Sensor {
  Coin(Vector2 position)
      : super.withAnimation(
          animation: CoinSpriteSheet.idle,
          position: position,
          size: Vector2(16, 16),
        );

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      removeFromParent();
      (component as Pacman).collectCoin();
    }
  }
}
