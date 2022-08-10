import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:pacman/entities/player.dart';

class CoinInterface extends InterfaceComponent {
  int coins = 0;
  
  CoinInterface() : super(
    id: 1,
    position: Vector2(32, 32),
    size: Vector2(120, 40)
  );

  @override
  void update(double dt) {
    if (gameRef.player != null) {
      Pacman player = gameRef.player as Pacman;
      coins = player.coins;
    }
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
    );

    TextSpan textSpan = TextSpan(
      text: "Coins: $coins",
      style: textStyle
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.x
    );

    var xCenter = (size.x - textPainter.width) / 2;
    var yCenter = (size.y - textPainter.height) / 2;

    textPainter.paint(c, Offset(xCenter, yCenter));
  }
}
