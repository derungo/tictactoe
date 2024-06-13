import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiDisplay extends StatefulWidget {
  final ConfettiController confettiController;

  ConfettiDisplay({Key? key, required this.confettiController}) : super(key: key);

  @override
  _ConfettiDisplayState createState() => _ConfettiDisplayState();
}

class _ConfettiDisplayState extends State<ConfettiDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 170.0), // Adjust padding to move right
            child: ConfettiWidget(
              confettiController: widget.confettiController,
              blastDirection: pi, // Pointing downwards
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 5,
              minBlastForce: 2,
              gravity: 0.1,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 170.0), // Adjust padding to move right
            child: ConfettiWidget(
              confettiController: widget.confettiController,
              blastDirection: pi, // Pointing downwards
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 5,
              minBlastForce: 2,
              gravity: 0.1,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: widget.confettiController,
            blastDirection: pi, // Pointing downwards
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            maxBlastForce: 5,
            minBlastForce: 2,
            gravity: 0.1,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: ConfettiWidget(
              confettiController: widget.confettiController,
              blastDirection: pi, // Pointing downwards
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              maxBlastForce: 5,
              minBlastForce: 2,
              gravity: 0.1,
            ),
          ),
        ),
      ],
    );
  }
}
