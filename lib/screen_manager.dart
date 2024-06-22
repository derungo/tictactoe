import 'package:flutter/material.dart';
import 'package:tictactoe/game_type_selection_screen.dart';
import 'package:tictactoe/game_selection_state.dart';
import 'package:tictactoe/tictactoe.dart';
import 'package:tictactoe/game_type_selection.dart'; // Import MarkerSelection and DifficultySelection
import 'video_player_widget.dart';
import 'package:provider/provider.dart';
import 'game_type.dart';
import 'package:flutter/services.dart'; // Import for system UI overlays

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
  bool _isOverlayVisible = false;

  void _toggleSystemUIOverlays() {
    if (_isOverlayVisible) {
      // Hide the status bar and navigation bar
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    } else {
      // Show the status bar and navigation bar
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 10 || details.primaryDelta! < -10) {
            _toggleSystemUIOverlays();
          }
        },
        child: Stack(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
