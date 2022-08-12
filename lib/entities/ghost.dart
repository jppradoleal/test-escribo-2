import 'package:bonfire/bonfire.dart';
import 'package:pacman/entities/player.dart';
import 'package:pacman/soundboard.dart';
import 'package:pacman/spritesheets/enemy_spritesheet.dart';

class Ghost extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement {
  bool canMove = false;
  final Vector2 initialPosition;

  Ghost(this.initialPosition)
      : super(
          position: initialPosition,
          size: Vector2(16, 16),
          animation: EnemySpriteSheet.simpleDirectionAnimation,
          life: 1,
          speed: 15
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(14, 14),
          )
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    seeAndMoveToPlayer(
      radiusVision: 16 * 10,
      closePlayer: (player) => attack(),
      notObserved: () {
        runRandomly(dt);
      },
      observed: () {
        Pacman player = gameRef.player as Pacman;

        if (player.isInvencible) {
          runRandomly(dt);
        }
      },
    );

    super.update(dt);
  }

  @override
  void die() {
    Soundboard.killEnemy();
    position = initialPosition;
  }

  void runRandomly(dt) {
    runRandomMovement(dt, speed: speed*1.3, maxDistance: 500, timeKeepStopped: 0,);
  }

  void attack() {
    simpleAttackMelee(damage: 1, size: Vector2(8, 8), interval: 0);
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    if (component is Player) {
      Pacman player = component as Pacman;
      if (player.isInvencible) {
        die();
        return false;
      }
    }

    return super.onCollision(component, active);
  }
}