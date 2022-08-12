import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:pacman/soundboard.dart';
import 'package:pacman/spritesheets/cookieman_spritesheet.dart';
import 'package:pacman/utils.dart';

class Cookieman extends SimplePlayer with ObjectCollision {
  bool isInvencible = false;
  int coins = 0;

  Cookieman(Vector2 position)
      : super(
            position: position,
            size: Vector2(16, 16),
            animation: CookiemanSpriteSheet.simpleDirectionAnimation,
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
  void joystickAction(JoystickActionEvent event) {
    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      Utils.playAgain(context);
    }

    super.joystickAction(event);
  }

  @override
  void die() {
    super.die();
    Soundboard.killPlayer();
    removeFromParent();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (!isInvencible) {
      super.receiveDamage(attacker, damage, identify);
    }
  }

  void triggerPowerUp(GameComponent powerup) {
    if (isInvencible) return;

    powerup.removeFromParent();
    Soundboard.powerUp();
    isInvencible = true;
    gameRef.colorFilter?.animateTo(Colors.purple);
    Future.delayed(
      const Duration(seconds: 5),
      () {
        isInvencible = false;
        gameRef.colorFilter?.animateTo(Colors.transparent);
      },
    );
  }

  void collectCoin() {
    coins += 1;
  }

  void collectSugar() {
    coins += 10;
    double boostSpeedAmount = speed * .5;
    speed += boostSpeedAmount;

    Future.delayed(
      const Duration(seconds: 1),
      () {
        speed -= boostSpeedAmount;
      },
    );
  }
}
