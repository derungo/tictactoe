

class GameLogic {
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

  static bool checkForDraw(List<String> cells) {
    return cells.every((cell) => cell.isNotEmpty);
  }
}