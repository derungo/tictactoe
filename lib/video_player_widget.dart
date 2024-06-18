import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  const VideoBackground({super.key});

  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _controller;
  late List<String> _videoAssets;
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _videoAssets = [
      'assets/animation_sky_grass_bubbles.mp4',
      'assets/animation_sky_grass_bubbles_reversed.mp4',
    ];
    _initializeAndPlay(_videoAssets[_currentVideoIndex]);
  }

  void _initializeAndPlay(String asset) {
    _controller = VideoPlayerController.asset(asset)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(false);
        _controller.play();
        _controller.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _currentVideoIndex = (_currentVideoIndex + 1) % _videoAssets.length;
      _controller.removeListener(_videoListener);
      _initializeAndPlay(_videoAssets[_currentVideoIndex]);
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
    return _controller.value.isInitialized
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
        : Container(color: Colors.blue);
  }
}
