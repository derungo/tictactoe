import 'package:flutter/material.dart';
import 'package:tictactoe/game_type_selection_screen.dart';
import 'package:tictactoe/game_selection_state.dart';
import 'package:tictactoe/tictactoe.dart';
import 'package:tictactoe/game_type_selection.dart'; // Import MarkerSelection and DifficultySelection
import 'video_player_widget.dart';
import 'package:provider/provider.dart';
import 'game_type.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const VideoBackground(),
          Consumer<GameSelectionState>(
            builder: (context, gameState, child) {
              print('GameSelectionState: $gameState');
              print('Selected GameType: ${gameState.selectedGameType}');
              print('Selected Marker: ${gameState.selectedMarker}');
              print('Selected Difficulty: ${gameState.selectedDifficulty}');
              if (gameState == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (gameState.selectedGameType == null) {
                return GameTypeSelectionScreen(
                  startGameCallback: (gameType, marker, difficulty) {
                    gameState.selectGameType(gameType);
                    gameState.selectMarker(marker);
                    if (difficulty != null) {
                      gameState.selectDifficulty(difficulty);
                    }
                  },
                );
              } else if (gameState.selectedMarker == null) {
                return MarkerSelection(
                  onSelect: (marker) {
                    gameState.selectMarker(marker);
                  },
                );
              } else if (gameState.selectedDifficulty == null && gameState.selectedGameType == GameType.singlePlayer) {
                return DifficultySelection(
                  onSelect: (difficulty) {
                    gameState.selectDifficulty(difficulty);
                  },
                );
              } else {
                return TicTacToe(
                  gameType: gameState.selectedGameType!,
                  marker: gameState.selectedMarker!,
                  difficulty: gameState.selectedDifficulty,
                  onBackToHome: () {
                    gameState.reset();
                  },
                );
              }
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Image.asset(
                    'assets/icons/home.png',
                    width: 24,
                    height: 24,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Provider.of<GameSelectionState>(context, listen: false).reset();
                  },
                ),
              ],
              title: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.black,
                      ),
                    ),
                    const Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
