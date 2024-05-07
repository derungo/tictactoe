import 'dart:math';
import 'package:confetti/confetti.dart'; // Import the confetti package

import 'package:flutter/cupertino.dart';


class ConfettiDisplay extends StatelessWidget {
  final ConfettiController _confettiController;

  ConfettiDisplay({Key? key}) :
        _confettiController = ConfettiController(duration: const Duration(seconds: 10)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    _confettiController.play();  // Start playing as soon as the widget is built
    return Stack(
      children: [
        for (int i = 0; i < 5; i++) // Adjust the number of confetti widgets as needed
          Positioned(
            left: MediaQuery.of(context).size.width * i / 5, // Divide the width evenly
            child: ConfettiWidget(
              key: ValueKey<int>(i), // Use a unique key for each confetti widget
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 20,
              minBlastForce: 10,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              shouldLoop: false, // Prevent looping to avoid continuous spawning
            ),
          ),
      ],
    );
  }
}