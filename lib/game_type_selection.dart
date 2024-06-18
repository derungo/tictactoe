import 'package:flutter/material.dart';
import 'package:tictactoe/game_type.dart';


class GameTypeSelection extends StatelessWidget {
  final Function(GameType) onSelect;
  const GameTypeSelection({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onSelect(GameType.singlePlayer),
          child: Image.asset('assets/1player.webp', scale: 4),
        ),
        const SizedBox(width: 20),
        Image.asset('assets/tictactoe.webp', scale: 2),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => onSelect(GameType.twoPlayer),
          child: Image.asset('assets/2player.webp', scale: 4),
        ),
      ],
    );
  }
}

class MarkerSelection extends StatelessWidget {
  final Function(Marker) onSelect;
  const MarkerSelection({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Which marker would you like to use?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => onSelect(Marker.X),
              child: Image.asset('assets/x.webp', scale: 2),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => onSelect(Marker.O),
              child: Image.asset('assets/o.webp', scale: 2),
            ),
          ],
        ),
      ],
    );
  }
}

class DifficultySelection extends StatelessWidget {
  final Function(Difficulty) onSelect;
  const DifficultySelection({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Select Difficulty:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => onSelect(Difficulty.easy),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Transform.scale(
                  scale: 0.75,
                  child: Image.asset('assets/easydog.webp'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onSelect(Difficulty.normal),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Transform.scale(
                  scale: 0.75,
                  child: Image.asset('assets/normalcat.webp'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onSelect(Difficulty.hard),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Transform.scale(
                  scale: 0.75,
                  child: Image.asset('assets/hardrat.webp'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
