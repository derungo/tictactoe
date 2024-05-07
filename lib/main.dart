import 'package:flutter/material.dart';
import 'cell.dart';
import 'confetti_widget.dart';
import 'tick_mark_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToe(),
    );
  }
}
class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> _cells = List.filled(9, '');

  String _currentPlayer = 'X';
  int _xWinsCount = 0;
  int _oWinsCount = 0;

  void _handleCellTap(int index) {
    if (_cells[index] == '') {
      _cells[index] = _currentPlayer;
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      setState(() {});
      if (_checkForWinner()) {
        _showWinnerDialog();
      } else if (_checkForDraw()) {
        _showDrawDialog();
      }
    }
  }

  bool _checkForWinner() {
    // Check rows
    for (int i = 0; i < 7; i += 3) {
      if (_cells[i] != '' &&
          _cells[i] == _cells[i + 1] &&
          _cells[i] == _cells[i + 2]) {
        return true;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_cells[i] != '' &&
          _cells[i] == _cells[i + 3] &&
          _cells[i] == _cells[i + 6]) {
        return true;
      }
    }
    // Check diagonals
    if (_cells[0] != '' &&
        _cells[0] == _cells[4] &&
        _cells[0] == _cells[8]) {
      return true;
    }
    if (_cells[2] != '' &&
        _cells[2] == _cells[4] &&
        _cells[2] == _cells[6]) {
      return true;
    }
    return false;
  }

  bool _checkForDraw() {
    return _cells.every((cell) => cell.isNotEmpty);
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: const Text('It\'s a draw!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: const Text('Play again'),
            ),
          ],
        );
      },
    );
  }


  void _showWinnerDialog() {
    // Increment win counter based on current player who is about to change
    String winner = _currentPlayer == 'X' ? 'O' : 'X';
    if (winner == 'X') {
      _xWinsCount++;
    } else {
      _oWinsCount++;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            AlertDialog(
              title: const Text('Game Over!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PLAYER $winner WINS!',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: const Text('Play again'),
                ),
              ],
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiDisplay(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    _cells = List.filled(9, '');
    _currentPlayer = 'X';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'X Wins',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TallyMarks(count: _xWinsCount),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 0; i < 9; i++)
                  Cell(
                    text: _cells[i],
                    onTap: () => _handleCellTap(i),
                    color: _cells[i] == 'X'
                        ? Colors.red
                        : _cells[i] == 'O'
                        ? Colors.green
                        : Colors.white,
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'O Wins',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TallyMarks(count: _oWinsCount),
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
    );
  }
}