import 'package:flutter/material.dart';

import 'confetti_widget.dart';

class ShowDialog {
  static void showWinnerDialog(BuildContext context, String winner, VoidCallback resetGame) {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            AlertDialog(
              title: const Text('Game Over!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PLAYER $winner WINS!',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  child: const Text('Play again'),
                ),
              ],
            ),
             Positioned.fill(
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiDisplay()
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showDrawDialog(BuildContext context, VoidCallback resetGame) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: const Text('It\'s a draw!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('Play again'),
            ),
          ],
        );
      },
    );
  }
}