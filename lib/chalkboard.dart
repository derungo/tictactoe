import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'tick_mark_display.dart';

class Chalkboard extends StatelessWidget {
  final String player;
  final int winsCount;
  final ui.Image chalkboardImage;
  final String currentPlayer;

  const Chalkboard({
    super.key,
    required this.player,
    required this.winsCount,
    required this.chalkboardImage,
    required this.currentPlayer,
  });

   @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: currentPlayer == player
                  ? BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    )
                  : null,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              margin: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$player Wins: $winsCount',
                    style: TextStyle(
                      fontSize: 30,
                      color: player == 'X' ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: TallyMarks(count: winsCount, chalkboardImage: chalkboardImage),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}