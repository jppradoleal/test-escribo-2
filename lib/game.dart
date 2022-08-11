import 'package:bonfire/bonfire.dart';
import 'package:bonfire/tiled/model/tiled_object_properties.dart';
import 'package:flutter/material.dart';
import 'package:pacman/entities/coin.dart';
import 'package:pacman/entities/ghost.dart';
import 'package:pacman/entities/player.dart';
import 'package:pacman/entities/powerup.dart';
import 'package:pacman/interfaces/pacman_interface.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>
    with WidgetsBindingObserver
    implements GameListener {
  bool showGameOver = false;

  late GameController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _controller = GameController()..addListener(this);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
      gameController: _controller,
      cameraConfig: CameraConfig(
        moveOnlyMapArea: false,
        zoom: 1.2,
      ),
      joystick: Joystick(
        directional: JoystickDirectional(),
      ),
      map: TiledWorldMap(
        'tiles/map.json',
        forceTileSize: const Size(16, 16),
        objectsBuilder: {
          'coin': (TiledObjectProperties properties) =>
              Coin(properties.position),
          'powerup': (TiledObjectProperties properties) =>
              Powerup(properties.position),
          'enemy': (TiledObjectProperties properties) =>
              Ghost(properties.position),
        },
      ),
      player: Pacman(Vector2(512, 272)),
      interface: PacmanInterface(),
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

  void _showDialogGameOver() {
    setState(() {
      showGameOver = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: playAgain,
                child: const Text(
                  "Play again",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Normal',
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void playAgain() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Game(),
      ),
      (route) => false,
    );
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    if (_controller.player != null && _controller.player?.isDead == true) {
      if (!showGameOver) {
        showGameOver = true;
        _showDialogGameOver();
      }
    }
  }
}
