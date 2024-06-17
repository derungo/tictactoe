import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _controller;
  late VideoPlayerController _reverseController;
  bool _isInitialized = false;
  bool _isReverseInitialized = false;
  int _currentVideoIndex = 0;
  List<VideoPlayerController> _videoControllers = [];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/animation_sky_grass_bubbles.mp4')
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(false);
        _controller.addListener(_videoListener);
        _controller.play();
        print('Original video initialized and playing.');
      }).catchError((error) {
        print('Error initializing video: $error');
      });

    _reverseController = VideoPlayerController.asset('assets/animation_sky_grass_bubbles_reversed.mp4')
      ..initialize().then((_) {
        setState(() {
          _isReverseInitialized = true;
        });
        _reverseController.setLooping(false);
        _reverseController.addListener(_videoListener);
        print('Reversed video initialized.');
      }).catchError((error) {
        print('Error initializing reverse video: $error');
      });

    _videoControllers = [_controller, _reverseController];
  }

  void _videoListener() {
    final currentController = _videoControllers[_currentVideoIndex];
    if (currentController.value.position >= currentController.value.duration) {
      _currentVideoIndex = (_currentVideoIndex + 1) % _videoControllers.length;
      final nextController = _videoControllers[_currentVideoIndex];
      nextController.seekTo(Duration.zero).then((_) {
        setState(() {});
        nextController.play();
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _reverseController.removeListener(_videoListener);
    _controller.dispose();
    _reverseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _isInitialized && _isReverseInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoControllers[_currentVideoIndex].value.size.width,
                    height: _videoControllers[_currentVideoIndex].value.size.height,
                    child: VideoPlayer(_videoControllers[_currentVideoIndex]),
                  ),
                ),
              )
            : Container(color: Colors.blue),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Removes shadow
            title: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Tic Tac Toe',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.black, // Stroke color
                    ),
                  ),
                  Text(
                    'Tic Tac Toe',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Fill color
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
