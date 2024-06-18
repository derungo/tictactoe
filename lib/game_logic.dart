class GameLogic {
  // Check for a winner
  static bool checkForWinner(List<String> cells) {
    for (int i = 0; i < 7; i += 3) {
      if (cells[i] != '' &&
          cells[i] == cells[i + 1] &&
          cells[i] == cells[i + 2]) {
        return true;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (cells[i] != '' &&
          cells[i] == cells[i + 3] &&
          cells[i] == cells[i + 6]) {
        return true;
      }
    }
    // Check diagonals
    if (cells[0] != '' &&
        cells[0] == cells[4] &&
        cells[0] == cells[8]) {
      return true;
    }
    if (cells[2] != '' &&
        cells[2] == cells[4] &&
        cells[2] == cells[6]) {
      return true;
    }
    return false;
  }

  // Check for a draw
  static bool checkForDraw(List<String> cells) {
    return cells.every((cell) => cell.isNotEmpty);
  }

  // Get a random move (Easy difficulty)
  static int getRandomMove(List<String> cells) {
    List<int> availableMoves = [];
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == '') {
        availableMoves.add(i);
      }
    }
    availableMoves.shuffle();
    return availableMoves.first;
  }

  // Get a normal move (Medium difficulty)
  static int getNormalMove(List<String> cells, String playerMarker, String aiMarker) {
    // Try to win
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == '') {
        cells[i] = aiMarker;
        if (checkForWinner(cells)) {
          cells[i] = '';
          return i;
        }
        cells[i] = '';
      }
    }

    // Block opponent from winning
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == '') {
        cells[i] = playerMarker;
        if (checkForWinner(cells)) {
          cells[i] = '';
          return i;
        }
        cells[i] = '';
      }
    }

    // Otherwise, pick a random move
    return getRandomMove(cells);
  }

  // Get a hard move (Hard difficulty)
  static int getHardMove(List<String> cells, String playerMarker, String aiMarker) {
    // Use minimax algorithm for the hard difficulty
    return minimax(cells, aiMarker, aiMarker, playerMarker).index!;
  }

  static MinimaxResult minimax(List<String> cells, String currentMarker, String aiMarker, String playerMarker) {
    List<int> availableMoves = [];
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == '') {
        availableMoves.add(i);
      }
    }

    if (checkForWinner(cells)) {
      return MinimaxResult(score: currentMarker == aiMarker ? -10 : 10);
    } else if (checkForDraw(cells)) {
      return MinimaxResult(score: 0);
    }

    List<MinimaxResult> moves = [];

    for (var move in availableMoves) {
      cells[move] = currentMarker;
      var result = minimax(cells, currentMarker == aiMarker ? playerMarker : aiMarker, aiMarker, playerMarker);
      moves.add(MinimaxResult(index: move, score: result.score));
      cells[move] = '';
    }

    MinimaxResult bestMove;
    if (currentMarker == aiMarker) {
      bestMove = moves.reduce((a, b) => a.score > b.score ? a : b);
    } else {
      bestMove = moves.reduce((a, b) => a.score < b.score ? a : b);
    }

    return bestMove;
  }
}

class MinimaxResult {
  final int? index;
  final int score;

  MinimaxResult({this.index, required this.score});
}
