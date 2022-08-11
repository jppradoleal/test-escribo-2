import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:pacman/game.dart';
import 'package:pacman/menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Flame.device.setLandscape();
    Flame.device.fullScreen();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cookie Man against Candle boys',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Menu(),
    );
  }
}