import 'package:bonfire/bonfire.dart';
import 'package:pacman/interfaces/coins_interface.dart';

class PacmanInterface extends GameInterface {
  @override
  Future<void>? onLoad() {
    add(CoinInterface());
    return super.onLoad();
  }
}