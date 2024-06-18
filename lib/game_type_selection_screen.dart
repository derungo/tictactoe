import 'package:flutter/material.dart';
import 'package:tictactoe/tictactoe.dart';

enum GameType { singlePlayer, twoPlayer }
enum Marker { X, O }
enum Difficulty { easy, normal, hard }

class GameTypeSelectionScreen extends StatefulWidget {
  const GameTypeSelectionScreen({super.key});

  @override
  _GameTypeSelectionScreenState createState() => _GameTypeSelectionScreenState();
}

class _GameTypeSelectionScreenState extends State<GameTypeSelectionScreen> {
  GameType? _selectedGameType;
  Marker? _selectedMarker;
  Difficulty? _selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Select Game Type',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Step 1: Choose Number of Players
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

          // Step 2: Choose Marker
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

          // Step 3: Choose Difficulty (for Single Player)
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

          // Start Two Player Game
          if (_selectedGameType == GameType.twoPlayer && _selectedMarker != null)
            ElevatedButton(
              onPressed: _startGame,
              child: const Text('Start Game'),
            ),
        ],
      ),
    );
  }

  void _startGame() {
    // Navigate to the TicTacToe game screen and pass the selected options
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicTacToe(
          gameType: _selectedGameType!,
          marker: _selectedMarker!,
          difficulty: _selectedGameType == GameType.singlePlayer ? _selectedDifficulty : null,
        ),
      ),
    );
  }
}
