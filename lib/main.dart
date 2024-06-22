import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_manager.dart';
import 'game_selection_state.dart';
import 'package:flutter/services.dart'; // Import for system UI overlays

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
    // Initially hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      title: 'Tic Tac Toe',
      home: ScreenManager(),
    );
  }
}
