import 'package:bonfire/bonfire.dart';
import 'package:bonfire/tiled/model/tiled_object_properties.dart';
import 'package:flutter/material.dart';
import 'package:pacman/entities/coin.dart';
import 'package:pacman/entities/ghost.dart';
import 'package:pacman/entities/player.dart';
import 'package:pacman/entities/powerup.dart';
import 'package:pacman/interfaces/pacman_interface.dart';
import 'package:pacman/soundboard.dart';
import 'package:pacman/utils.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>
    with WidgetsBindingObserver
    implements GameListener {
  bool showGameOver = false;
  int mapWidth = 31 * 16;
  int mapHeight = 16 * 16;

  late GameController _controller;
  late int maxCoins;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _controller = GameController()..addListener(this);
    maxCoins = 179;
    Soundboard.playBGM();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Soundboard.stopBGM();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TiledWorldMap map = TiledWorldMap(
      'tiles/map.json',
      forceTileSize: const Size(16, 16),
      objectsBuilder: {
        'coin': (TiledObjectProperties properties) => Coin(properties.position),
        'powerup': (TiledObjectProperties properties) =>
            Powerup(properties.position),
        'enemy': (TiledObjectProperties properties) =>
            Ghost(properties.position),
      },
    );

    return BonfireTiledWidget(
      gameController: _controller,
      cameraConfig: CameraConfig(
        moveOnlyMapArea: false,
        zoom: 1.2,
      ),
      joystick: Joystick(directional: JoystickDirectional(), actions: [
        JoystickAction(
          actionId: 1,
          sprite: Sprite.load('sprites/retry.png'),
          size: 50,
          align: JoystickActionAlign.TOP_RIGHT,
          margin: const EdgeInsets.only(top: 32, right: 32),
        )
      ]),
      map: map,
      player: Pacman(Vector2(32, 32)),
      interface: PacmanInterface(),
      colorFilter: GameColorFilter(),
      background: BackgroundColorGame(
        const Color.fromARGB(255, 109, 6, 115),
      ),
      progress: const Center(
        child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.purple,
              fontFamily: 'Normal',
              fontSize: 20.0,
            ),
            child: Text(
              'Loading...',
            )),
      ),
      // colorFilter: GameColorFilter(color: Colors.purple),
    );
  }

  void _showDialogGameOver(String text) {
    setState(() {
      showGameOver = true;
    });

    Utils.showGameOverDialog(context, text);
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    Player? player = _controller.player;

    if (player != null) {
      bool collectedAllCoins = (player as Pacman).coins == maxCoins;
      if (player.isDead == true || collectedAllCoins) {
        if (!showGameOver) {
          _showDialogGameOver(
            collectedAllCoins
                ? 'assets/images/play-again.png'
                : 'assets/images/game-over.png',
          );
        }
      }
    }

    for (GameComponent entity
        in _controller.livingEnemies ?? const Iterable.empty()) {
      keepEntityInsideMap(entity);
    }

    keepEntityInsideMap(player as GameComponent);
  }

  void keepEntityInsideMap(GameComponent entity) {
    if (entity.x > mapWidth) {
      entity.x = 0;
    } else if (entity.x < 0) {
      entity.x = mapWidth - 17;
    }

    if (entity.y > mapHeight) {
      entity.y = 0;
    } else if (entity.y < 0) {
      entity.y = mapHeight - 17;
    }
  }
}
