import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool showSplash = true;
  int currentPosition = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildSplash() {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      onFinish: (BuildContext context) {
        setState(() {
          showSplash = false;
        });
      },
    );
  }

  Widget buildMenu() {
    const TextStyle headerStyle = TextStyle(
      color: Colors.black,
      fontFamily: 'Normal',
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: const [
                Text('Cookie-man against', style: headerStyle),
                Text('Candle Boys', style: headerStyle),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: const Size(100, 40),
                ),
                onPressed: play,
                child: const Text(
                  'Play',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Normal',
                    fontSize: 17,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void play() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Game(),
      ),
    );
  }
}
