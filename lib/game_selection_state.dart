import 'package:flutter/foundation.dart';
import 'game_type.dart';

class GameSelectionState extends ChangeNotifier {
  GameType? selectedGameType;
  Marker? selectedMarker;
  Difficulty? selectedDifficulty;

  void selectGameType(GameType gameType) {
    selectedGameType = gameType;
    notifyListeners();
  }

  void selectMarker(Marker marker) {
    selectedMarker = marker;
    notifyListeners();
  }

  void selectDifficulty(Difficulty? difficulty) {
    selectedDifficulty = difficulty;
    notifyListeners();
  }

  void reset() {
    selectedGameType = null;
    selectedMarker = null;
    selectedDifficulty = null;
    notifyListeners();
  }
}
