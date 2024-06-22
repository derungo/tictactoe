import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'tick_mark_display.dart';

class Chalkboard extends StatelessWidget {
  final String player;
  final int winsCount;
  final ui.Image chalkboardImage;
  final String currentPlayer;

  const Chalkboard({
    super.key,
    required this.player,
    required this.winsCount,
    required this.chalkboardImage,
    required this.currentPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: currentPlayer == player
          ? BoxDecoration(
        border: Border.all(color: Colors.yellow, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
      )
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      margin: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$player Wins: $winsCount',
            style: TextStyle(
              fontSize: 30,
              color: player == 'X' ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 3.85, // Adjust this to maintain the aspect ratio of the chalkboard image
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: ChalkboardPainter(chalkboardImage),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TallyMarks(count: winsCount),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChalkboardPainter extends CustomPainter {
  final ui.Image chalkboardImage;

  ChalkboardPainter(this.chalkboardImage);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate width scaling factor
    double widthScaleFactor = size.width / chalkboardImage.width.toDouble();

    // Double the height
    double heightScaleFactor = widthScaleFactor * 1.25;

    // Calculate destination rectangle
    Rect destinationRect = Rect.fromLTWH(
        0,
        0,
        chalkboardImage.width.toDouble() * widthScaleFactor, // Keep width scale factor the same
        chalkboardImage.height.toDouble() * heightScaleFactor // Double the height scale factor
    );

    // Draw chalkboard image with the calculated destination rectangle
    canvas.drawImageRect(
      chalkboardImage, // Image to draw
      Rect.fromLTWH(0, 0, chalkboardImage.width.toDouble(), chalkboardImage.height.toDouble()), // Source rect
      destinationRect, // Destination rect
      Paint(), // Paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
