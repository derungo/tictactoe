import 'package:flutter/material.dart';
import 'game_type.dart'; // Import GameType from game_type.dart


class GameTypeSelectionScreen extends StatefulWidget {
  final Function(GameType, Marker, Difficulty?) startGameCallback;

  const GameTypeSelectionScreen({super.key, required this.startGameCallback});

  @override
  _GameTypeSelectionScreenState createState() => _GameTypeSelectionScreenState();
}

class _GameTypeSelectionScreenState extends State<GameTypeSelectionScreen> {
  GameType? _selectedGameType;
  Marker? _selectedMarker;
  Difficulty? _selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_selectedGameType == null)
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedGameType = GameType.singlePlayer;
                  });
                },
                child: const Text('Single Player'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedGameType = GameType.twoPlayer;
                  });
                },
                child: const Text('Two Player'),
              ),
            ],
          ),
        if (_selectedGameType != null && _selectedMarker == null)
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedMarker = Marker.X;
                  });
                },
                child: const Text('Play as X'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedMarker = Marker.O;
                  });
                },
                child: const Text('Play as O'),
              ),
            ],
          ),
        if (_selectedGameType == GameType.singlePlayer && _selectedMarker != null && _selectedDifficulty == null)
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedDifficulty = Difficulty.easy;
                    _startGame();
                  });
                },
                child: const Text('Good Dog (Easy)'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedDifficulty = Difficulty.normal;
                    _startGame();
                  });
                },
                child: const Text('Sneaky Kitty (Normal)'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedDifficulty = Difficulty.hard;
                    _startGame();
                  });
                },
                child: const Text('Top Hat Rat (Hard)'),
              ),
            ],
          ),
        if (_selectedGameType == GameType.twoPlayer && _selectedMarker != null)
          ElevatedButton(
            onPressed: _startGame,
            child: const Text('Start Game'),
          ),
      ],
    );
  }

  void _startGame() {
    widget.startGameCallback(_selectedGameType!, _selectedMarker!, _selectedGameType == GameType.singlePlayer ? _selectedDifficulty : null);
  }
}
