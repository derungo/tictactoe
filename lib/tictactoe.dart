import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/game_logic.dart';
import 'package:tictactoe/show_dialog.dart';
import 'cell.dart';
import 'tick_mark_display.dart';
import 'confetti_widget.dart';
import 'package:confetti/confetti.dart';
import 'game_type.dart';

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
    _chalkboardImageFuture = _loadChalkboardImage();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<ui.Image> _loadChalkboardImage() async {
    final ByteData data = await rootBundle.load('assets/chalkboard1.jpeg');
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
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

  Widget _buildChalkboard(String player, int winsCount, ui.Image chalkboardImage) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 500,
            decoration: _currentPlayer == player
                ? BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  )
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            margin: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$player Wins: $winsCount',
                  style: TextStyle(
                    fontSize: 30,
                    color: player == 'X' ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TallyMarks(count: winsCount, chalkboardImage: chalkboardImage),
              ],
            ),
          ),
        ],
      ),
    );
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
                          _buildChalkboard('X', _xWinsCount, chalkboardImage),
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
                                      color: _cells[index] == 'X' ? Colors.red : _cells[index] == 'O' ? Colors.green : Colors.white,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          _buildChalkboard('O', _oWinsCount, chalkboardImage),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _currentPlayer == 'X' ? Colors.red : Colors.green,
                        ),
                        color: _currentPlayer == 'X' ? Colors.red : Colors.green,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'It is $_currentPlayer\'s Turn',
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
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