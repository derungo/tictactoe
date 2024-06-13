import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'confetti_widget.dart';

class ShowDialog {
  static void showWinnerDialog(BuildContext context, String winner, VoidCallback resetGame) {
    final ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 10));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      confettiController.play(); // Start confetti after the frame is rendered
    });

    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AlertDialog(
              title: const Text('Game Over!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Winner: $winner'),
                  ElevatedButton(
                    onPressed: () {
                      resetGame();
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            ),
            ConfettiDisplay(confettiController: confettiController),
          ],
        );
      },
    ).then((_) {
      confettiController.dispose();
    });
  }

  static void showDrawDialog(BuildContext context, VoidCallback resetGame) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('It\'s a Draw!'),
              ElevatedButton(
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
        );
      },
    );
  }
}
