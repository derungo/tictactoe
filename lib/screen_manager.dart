import 'package:flutter/material.dart';
import 'package:tictactoe/game_type_selection_screen.dart';
import 'package:tictactoe/game_selection_state.dart';
import 'package:tictactoe/tictactoe.dart';
import 'package:tictactoe/game_type_selection.dart'; // Import MarkerSelection and DifficultySelection
import 'video_player_widget.dart';
import 'package:provider/provider.dart';
import 'game_type.dart';

/// The `ScreenManager` widget is a StatefulWidget responsible for managing
/// and displaying different screens within the Tic Tac Toe application.
/// It serves as the main navigation hub that transitions between the
/// game type selection, marker selection, difficulty selection, and the
/// actual game screens based on the user's choices.
class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

/// The `_ScreenManagerState` class is the stateful implementation for the `ScreenManager`.
/// It uses a `Consumer` to listen for changes in the `GameSelectionState` and updates
/// the UI accordingly.
class _ScreenManagerState extends State<ScreenManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The `VideoBackground` widget provides a looping video background
          // for the Tic Tac Toe game screens.
          const VideoBackground(),
          
          // The `Consumer` widget listens to the `GameSelectionState` and rebuilds
          // the UI when there are changes in the state.
          Consumer<GameSelectionState>(
            builder: (context, gameState, child) {
              // Debug prints to log the current state of the game selection.
              print('GameSelectionState: $gameState');
              print('Selected GameType: ${gameState.selectedGameType}');
              print('Selected Marker: ${gameState.selectedMarker}');
              print('Selected Difficulty: ${gameState.selectedDifficulty}');
              
              // If the game state is null, show a loading indicator.
              if (gameState == null) {
                return const Center(child: CircularProgressIndicator());
              }

              // If no game type is selected, show the `GameTypeSelectionScreen`.
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
              } 
              // If a game type is selected but no marker is chosen, show the `MarkerSelection`.
              else if (gameState.selectedMarker == null) {
                return MarkerSelection(
                  onSelect: (marker) {
                    gameState.selectMarker(marker);
                  },
                );
              } 
              // If in single player mode and no difficulty is chosen, show the `DifficultySelection`.
              else if (gameState.selectedDifficulty == null && gameState.selectedGameType == GameType.singlePlayer) {
                return DifficultySelection(
                  onSelect: (difficulty) {
                    gameState.selectDifficulty(difficulty);
                  },
                );
              } 
              // Otherwise, show the Tic Tac Toe game screen.
              else {
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

          // The `AppBar` widget is positioned at the top of the screen
          // and provides a transparent background with a home button.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                // The home button icon. When pressed, it resets the game state
                // and navigates back to the home screen.
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
              // The title of the app displayed at the center of the app bar.
              title: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Text outline for the title.
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
                    // The filled text for the title.
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
