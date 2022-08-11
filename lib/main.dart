import 'package:bonfire/tiled/model/tiled_object_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bonfire/bonfire.dart';
import 'package:pacman/entities/ghost.dart';
import 'package:pacman/entities/player.dart';
import 'package:pacman/entities/coin.dart';
import 'package:pacman/entities/powerup.dart';
import 'package:pacman/interfaces/pacman_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Game(),
    );
  }
}

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
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
          'coin': (TiledObjectProperties properties) => Coin(properties.position),
          'powerup': (TiledObjectProperties properties) => Powerup(properties.position),
          'enemy': (TiledObjectProperties properties) => Ghost(properties.position),
        },
      ),
      player: Pacman(Vector2(512, 272)),
      interface: PacmanInterface(),
      colorFilter: GameColorFilter(color: Colors.purple),
    );
  }
}
