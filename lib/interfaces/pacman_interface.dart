import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:pacman/interfaces/coins_interface.dart';

class PacmanInterface extends GameInterface {
  @override
  Future<void>? onLoad() {
    add(CoinInterface());
    return super.onLoad();
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }
}