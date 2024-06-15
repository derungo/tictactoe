import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _controller;
  bool _isReversing = false;
  bool _isInitialized = false;
  bool _isReversingPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/animation_sky_grass_bubbles.mp4')
      ..initialize().then((_) {
        _isInitialized = true;
        _controller.setLooping(false); // Disable normal looping
        _controller.play();
        setState(() {});
        _controller.addListener(_videoListener);
      }).catchError((error) {
        print('Error initializing video: $error'); // Debug error handling
      });
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration && !_isReversing) {
      _reverseVideo();
    }
  }

  void _reverseVideo() async {
    _isReversing = true;
    _isReversingPlaying = true;
    while (_controller.value.position > Duration.zero && _isReversingPlaying) {
      await Future.delayed(Duration(milliseconds: 33)); // Adjust this for smoothness
      final currentPosition = _controller.value.position;
      final newPosition = currentPosition - Duration(milliseconds: 33); // Rewind step
      _controller.seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
      if (newPosition <= Duration.zero) {
        _isReversingPlaying = false;
      }
    }
    _controller.play();
    _isReversing = false;
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
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
        : Container(color: Colors.black);
  }
}
