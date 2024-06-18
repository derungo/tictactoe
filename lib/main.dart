import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_manager.dart';
import 'game_selection_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameSelectionState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: ScreenManager(),
    );
  }
}
