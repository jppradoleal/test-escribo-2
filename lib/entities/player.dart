import 'package:bonfire/bonfire.dart';
import 'package:pacman/spritesheets/pacman_spritesheet.dart';

class Pacman extends SimplePlayer with ObjectCollision {
  bool isInvencible = false;
  int coins = 0;

  Pacman(Vector2 position)
      : super(
            position: position,
            size: Vector2(16, 16),
            animation: PacmanSpriteSheet.simpleDirectionAnimation,
            life: 1) {
    setupCollision(
      CollisionConfig(
        enable: true,
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(14, 14),
            align: Vector2(1, 1),
          ),
        ],
      ),
    );
  }

  @override
  void die() {
    super.die();
    removeFromParent();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (!isInvencible) {
      super.receiveDamage(attacker, damage, identify);
    }
  }

  void triggerPowerUp() {
    isInvencible = true;
    Future.delayed(
      const Duration(seconds: 5),
      () {
        isInvencible = false;
      },
    );
  }

  void collectCoin() {
    coins += 1;
  }
}
