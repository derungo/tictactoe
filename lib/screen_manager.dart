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
        onBackToHome: _backToHome,
      );
    });
  }

  void _backToHome() {
    setState(() {
      _currentScreen = GameTypeSelectionScreen(startGameCallback: _startGame);
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const VideoBackground(),
          _currentScreen,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/icons/home.png',
                      width: 24,
                      height: 24,
                      color: Colors.black, // Ensure icon color contrasts with background
                    ),
                    onPressed: _backToHome,
                  ),
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
                          ..color = Colors.black, // Stroke color
                      ),
                    ),
                    const Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Fill color
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