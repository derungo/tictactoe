import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/game_logic.dart';
import 'package:tictactoe/show_dialog.dart';
import 'cell.dart';
import 'tick_mark_display.dart';
import 'confetti_widget.dart';
import 'package:confetti/confetti.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late ui.Image chalkboardImage; // Image to draw
  List<String> _cells = List.filled(9, '');
  String _currentPlayer = 'X';
  int _xWinsCount = 0;
  int _oWinsCount = 0;

  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 10));

  @override
  void initState() {
    super.initState();
    _resetGame();
    _loadChalkboardImage();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _loadChalkboardImage() async {
    final ByteData data = await rootBundle.load('assets/chalkboard1.jpeg');
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    setState(() {
      chalkboardImage = frameInfo.image;
    });
  }

  void _handleCellTap(int index) {
    if (_cells[index] == '') {
      _cells[index] = _currentPlayer;
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      setState(() {});
      if (GameLogic.checkForWinner(_cells)) {
        setState(() {
          if (_currentPlayer == 'X') {
            _oWinsCount++;
          } else {
            _xWinsCount++;
          }
        });
        ShowDialog.showWinnerDialog(context, _currentPlayer == 'X' ? 'O' : 'X', _resetGame);
      } else if (GameLogic.checkForDraw(_cells)) {
        ShowDialog.showDrawDialog(context, _resetGame);
      }
    }
  }

  void _resetGame() {
    _cells = List.filled(9, '');
    _currentPlayer = 'X';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Toe')),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'X Wins: $_xWinsCount',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (chalkboardImage != null)
                            TallyMarks(count: _xWinsCount, chalkboardImage: chalkboardImage),
                        ],
                      ),
                    ),
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          margin: EdgeInsets.all(16.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'O Wins: $_oWinsCount',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (chalkboardImage != null)
                            TallyMarks(count: _oWinsCount, chalkboardImage: chalkboardImage),
                        ],
                      ),
                    ),
                  ],
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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
}
