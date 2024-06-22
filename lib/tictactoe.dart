import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tictactoe/game_logic.dart';
import 'package:tictactoe/show_dialog.dart';
import 'package:tictactoe/cell.dart';
import 'package:tictactoe/chalkboard.dart';
import 'package:tictactoe/confetti_widget.dart';
import 'package:confetti/confetti.dart';
import 'package:tictactoe/game_type.dart';
import 'package:tictactoe/image_loader.dart';

class TicTacToe extends StatefulWidget {
  final GameType gameType;
  final Marker marker;
  final Difficulty? difficulty;
  final VoidCallback onBackToHome;

  const TicTacToe({
    super.key,
    required this.gameType,
    required this.marker,
    this.difficulty,
    required this.onBackToHome,
  });

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late Future<ui.Image> _chalkboardImageFuture;
  List<String> _cells = List.filled(9, '');
  late String _currentPlayer;
  int _xWinsCount = 0;
  int _oWinsCount = 0;

  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 10));

  @override
  void initState() {
    super.initState();
    _resetGame();
    _chalkboardImageFuture = ImageLoader.loadChalkboardImage();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handleCellTap(int index) {
    if (_cells[index] == '') {
      _cells[index] = _currentPlayer;
      if (GameLogic.checkForWinner(_cells)) {
        setState(() {
          if (_currentPlayer == 'X') {
            _xWinsCount++;
          } else {
            _oWinsCount++;
          }
        });
        _confettiController.play();
        ShowDialog.showWinnerDialog(context, _currentPlayer, _resetGame);
      } else if (GameLogic.checkForDraw(_cells)) {
        ShowDialog.showDrawDialog(context, _resetGame);
      } else {
        _switchPlayer();
        if (widget.gameType == GameType.singlePlayer && _currentPlayer != _playerMarker()) {
          _handleAITurn();
        }
      }
    }
  }

  void _handleAITurn() {
    int aiMove;
    if (widget.difficulty == Difficulty.easy) {
      aiMove = GameLogic.getRandomMove(_cells);
    } else if (widget.difficulty == Difficulty.normal) {
      aiMove = GameLogic.getNormalMove(_cells, _playerMarker(), _aiMarker());
    } else {
      aiMove = GameLogic.getHardMove(_cells, _playerMarker(), _aiMarker());
    }
    _handleCellTap(aiMove);
  }

  void _switchPlayer() {
    setState(() {
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    });
  }

  String _playerMarker() {
    return widget.marker == Marker.X ? 'X' : 'O';
  }

  String _aiMarker() {
    return widget.marker == Marker.X ? 'O' : 'X';
  }

  void _resetGame() {
    setState(() {
      _cells = List.filled(9, '');
      _currentPlayer = _playerMarker();
    });
    if (widget.gameType == GameType.singlePlayer && _currentPlayer != _playerMarker()) {
      _handleAITurn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _chalkboardImageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading image: ${snapshot.error}'),
          );
        } else {
          final chalkboardImage = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Chalkboard(
                                player: 'X',
                                winsCount: _xWinsCount,
                                chalkboardImage: chalkboardImage,
                                currentPlayer: _currentPlayer,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                      childAspectRatio: 1.0, // Ensures cells are square
                                    ),
                                    itemCount: 9,
                                    itemBuilder: (context, index) {
                                      return Cell(
                                        text: _cells[index],
                                        onTap: () => _handleCellTap(index),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Chalkboard(
                                player: 'O',
                                winsCount: _oWinsCount,
                                chalkboardImage: chalkboardImage,
                                currentPlayer: _currentPlayer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10), // Keep the space


                    ],
                  ),
                  ConfettiDisplay(confettiController: _confettiController),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
