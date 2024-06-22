import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_manager.dart';
import 'game_selection_state.dart';
import 'video_player_widget.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initially hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // No need for a delayed navigation since we are handling touch events
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ScreenManager()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToHome, // Detect touch anywhere on the screen
      child: Scaffold(
        body: Stack(
          children: [
            const VideoBackground(),
            Center(
              child: Image.asset(
                'assets/tictactoe.webp',
                width: 500, // Adjust the size as needed
                height: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
