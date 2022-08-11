import 'package:flutter/material.dart';
import 'package:pacman/game.dart';

class Utils {
  static void playAgain(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const Game(),
      ),
      (route) => false,
    );
  }

  static void showGameOverDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Normal',
                  fontSize: 32.0,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () => Utils.playAgain(context),
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
}
