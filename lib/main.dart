import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_manager.dart';
import 'game_selection_state.dart';

/// The main entry point of the application.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameSelectionState(),
      child: MyApp(),
    ),
  );
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: ScreenManager(),
    );
  }
}
