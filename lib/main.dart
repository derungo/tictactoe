//main.dart
import 'package:flutter/material.dart';
import 'package:tictactoe/tictactoe.dart';
import 'video_player_widget.dart'; // Import the video player widget

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: GameWithBackground(),
    );
  }
}
class GameWithBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoBackground(),
          TicTacToe(), // Your game widget
        ],
      ),
    );
  }
}