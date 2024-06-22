import 'package:flutter/material.dart';
import 'package:tictactoe/game_type.dart';


class GameTypeSelection extends StatelessWidget {
  final Function(GameType) onSelect;
  const GameTypeSelection({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double scale = 4;
        double spacing = 20;

        // Adjust the scale and spacing based on the available width
        if (constraints.maxWidth < 800) {
          scale = 3;
          spacing = 15;
        }
        if (constraints.maxWidth < 600) {
          scale = 2.5;
          spacing = 10;
        }

        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: GestureDetector(
                onTap: () => onSelect(GameType.singlePlayer),
                child: Image.asset('assets/1player.webp', scale: scale),
              ),
            ),
            SizedBox(width: spacing),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Image.asset('assets/tictactoe.webp', scale: scale / 2),
            ),
            SizedBox(width: spacing),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: GestureDetector(
                onTap: () => onSelect(GameType.twoPlayer),
                child: Image.asset('assets/2player.webp', scale: scale),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MarkerSelection extends StatelessWidget {
  final Function(Marker) onSelect;
  const MarkerSelection({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the entire column
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                child: Image.asset('assets/x.webp', scale: 4), // Adjusted scale value
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => onSelect(Marker.O),
                child: Image.asset('assets/o.webp', scale: 4), // Adjusted scale value
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DifficultySelection extends StatelessWidget {
  final Function(Difficulty) onSelect;
  const DifficultySelection({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the entire column
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Select Difficulty:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onSelect(Difficulty.easy),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/easydog.webp', fit: BoxFit.contain),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onSelect(Difficulty.normal),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/normalcat.webp', fit: BoxFit.contain),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onSelect(Difficulty.hard),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/hardrat.webp', fit: BoxFit.contain),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}