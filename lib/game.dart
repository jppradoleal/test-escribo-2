import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/tiled/model/tiled_object_properties.dart';
import 'package:flutter/material.dart';
import 'package:pacman/entities/coin.dart';
import 'package:pacman/entities/candleboy.dart';
import 'package:pacman/entities/cookieman.dart';
import 'package:pacman/entities/powerup.dart';
import 'package:pacman/entities/sugar.dart';
import 'package:pacman/interfaces/cookieman_interface.dart';
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
  final Random _rnd = Random();
  bool showGameOver = false;
  int mapHeight = 16 * 16;
  int mapWidth = 31 * 16;
  int sugarAmount = 0;
  int maxSugar = 4;

  late GameController _controller;
  late int maxScore;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _controller = GameController()..addListener(this);
    maxScore = 0;
    Soundboard.playBGM();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Soundboard.playBGM();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        Soundboard.stopBGM();
        break;
      case AppLifecycleState.detached:
        Soundboard.stopBGM();
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
        'coin': (TiledObjectProperties properties) =>
            spawnScorePoints(properties.position),
        'powerup': (TiledObjectProperties properties) =>
            Powerup(properties.position),
        'enemy': (TiledObjectProperties properties) =>
            CandleBoy(properties.position),
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
      player: Cookieman(Vector2(32, 32)),
      interface: CookiemanInterface(),
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

  GameDecoration spawnScorePoints(Vector2 position) {
    if (_rnd.nextInt(10) > 5 && sugarAmount <= maxSugar) {
      maxScore += 10;
      sugarAmount++;
      return Sugar(position);
    }
    maxScore += 1;
    return Coin(position);
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
      bool collectedAllCoins = (player as Cookieman).coins == maxScore;
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
