import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoBackground extends StatefulWidget {
  const VideoBackground({super.key});

  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _controller;
  final List<String> _videoPaths = [
    'assets/animation_sky_grass_bubbles.mp4',
    'assets/animation_sky_grass_bubbles_reversed.mp4',
  ];
  int _currentVideoIndex = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(_videoPaths[_currentVideoIndex])
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(false);
        _controller.addListener(_videoListener);
        _controller.play();
        print('Video initialized and playing.');
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _currentVideoIndex = (_currentVideoIndex + 1) % _videoPaths.length;
      _controller.removeListener(_videoListener);
      _controller.pause();
      _controller = VideoPlayerController.asset(_videoPaths[_currentVideoIndex])
        ..initialize().then((_) {
          setState(() {});
          _controller.setLooping(false);
          _controller.addListener(_videoListener);
          _controller.play();
        }).catchError((error) {
          print('Error initializing video: $error');
        });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
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
                  const Text(
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