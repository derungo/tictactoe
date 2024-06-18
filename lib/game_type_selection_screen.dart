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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row for the game type selection images and title image
          Visibility(
            visible: _selectedGameType == null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Single player button with image
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGameType = GameType.singlePlayer;
                    });
                  },
                  child: Image.asset('assets/1player.webp', scale: 4),
                ),
                const SizedBox(width: 20), // Space between images
                // Title image with reduced size
                Image.asset('assets/tictactoe.webp', scale: 2),
                const SizedBox(width: 20), // Space between images
                // Two player button with image
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGameType = GameType.twoPlayer;
                    });
                  },
                  child: Image.asset('assets/2player.webp', scale: 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Marker selection based on game type
          Visibility(
            visible: _selectedGameType != null && _selectedMarker == null,
            child: Column(
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
                      onTap: () {
                        setState(() {
                          _selectedMarker = Marker.X;
                        });
                      },
                      child: Image.asset('assets/x.webp', scale: 1),
                    ),
                    const SizedBox(width: 20), // Space between images
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMarker = Marker.O;
                        });
                      },
                      child: Image.asset('assets/o.webp', scale: 1),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Difficulty selection for single player game
          Visibility(
            visible: _selectedGameType == GameType.singlePlayer && _selectedMarker != null && _selectedDifficulty == null,
            child: Column(
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
                      onTap: () {
                        setState(() {
                          _selectedDifficulty = Difficulty.easy;
                          _startGame();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Transform.scale(
                          scale: 0.50,
                          child: Image.asset('assets/easydog.webp'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDifficulty = Difficulty.normal;
                          _startGame();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Transform.scale(
                          scale: 0.50,
                          child: Image.asset('assets/normalcat.webp'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDifficulty = Difficulty.hard;
                          _startGame();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Transform.scale(
                          scale: 0.50,
                          child: Image.asset('assets/hardrat.webp'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Start game button for two player game
          Visibility(
            visible: _selectedGameType == GameType.twoPlayer && _selectedMarker != null,
            child: ElevatedButton(
              onPressed: _startGame,
              child: const Text('Start Game'),
            ),
          ),
        ],
      ),
    );
  }

  void _startGame() {
    widget.startGameCallback(_selectedGameType!, _selectedMarker!, _selectedGameType == GameType.singlePlayer ? _selectedDifficulty : null);
  }
}
