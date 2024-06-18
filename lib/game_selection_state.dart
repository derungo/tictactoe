import 'package:flutter/material.dart';
import 'package:tictactoe/game_type.dart';

class GameSelectionState with ChangeNotifier {
  GameType? _selectedGameType;
  Marker? _selectedMarker;
  Difficulty? _selectedDifficulty;

  GameType? get selectedGameType => _selectedGameType;
  Marker? get selectedMarker => _selectedMarker;
  Difficulty? get selectedDifficulty => _selectedDifficulty;

  void selectGameType(GameType gameType) {
    _selectedGameType = gameType;
    _selectedMarker = null;
    _selectedDifficulty = null;
    notifyListeners();
  }

  void selectMarker(Marker marker) {
    _selectedMarker = marker;
    notifyListeners();
  }

  void selectDifficulty(Difficulty difficulty) {
    _selectedDifficulty = difficulty;
    notifyListeners();
  }

  void reset() {
    _selectedGameType = null;
    _selectedMarker = null;
    _selectedDifficulty = null;
    notifyListeners();
  }
}
