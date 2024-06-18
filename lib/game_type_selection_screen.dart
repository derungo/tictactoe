//game_type_selection_screen.dart file
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/game_type.dart';
import 'package:tictactoe/game_selection_state.dart';
import 'package:tictactoe/game_type_selection.dart';

class GameTypeSelectionScreen extends StatelessWidget {
  final Function(GameType, Marker, Difficulty?) startGameCallback;

  const GameTypeSelectionScreen({super.key, required this.startGameCallback});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameSelectionState>(
      builder: (context, gameState, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (gameState.selectedGameType == null)
                GameTypeSelection(
                  onSelect: (gameType) => gameState.selectGameType(gameType),
                ),
              if (gameState.selectedGameType != null && gameState.selectedMarker == null)
                MarkerSelection(
                  onSelect: (marker) => gameState.selectMarker(marker),
                ),
              if (gameState.selectedGameType == GameType.singlePlayer &&
                  gameState.selectedMarker != null &&
                  gameState.selectedDifficulty == null)
                DifficultySelection(
                  onSelect: (difficulty) => gameState.selectDifficulty(difficulty),
                ),
              if (gameState.selectedGameType == GameType.twoPlayer && gameState.selectedMarker != null)
                ElevatedButton(
                  onPressed: () => startGameCallback(
                    gameState.selectedGameType!,
                    gameState.selectedMarker!,
                    gameState.selectedDifficulty,
                  ),
                  child: const Text('Start Game'),
                ),
            ],
          ),
        );
      },
    );
  }
}
