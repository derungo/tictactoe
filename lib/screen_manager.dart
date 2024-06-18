import 'package:flutter/material.dart';
import 'package:tictactoe/game_type.dart';
import 'package:tictactoe/game_type_selection_screen.dart';
import 'package:tictactoe/tictactoe.dart';
import 'video_player_widget.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  Widget _currentScreen = Container(); // Placeholder

  @override
  void initState() {
    super.initState();
    _currentScreen = GameTypeSelectionScreen(startGameCallback: _startGame);
  }

  void _startGame(GameType gameType, Marker marker, Difficulty? difficulty) {
    setState(() {
      _currentScreen = TicTacToe(
        gameType: gameType,
        marker: marker,
        difficulty: difficulty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const VideoBackground(),
          _currentScreen,
        ],
      ),
    );
  }
}
