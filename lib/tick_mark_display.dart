import 'dart:ui' as ui;


import 'package:flutter/material.dart';

class TallyMarksPainter extends CustomPainter {
  final int count;
  final ui.Image chalkboardImage;

  TallyMarksPainter(this.count, this.chalkboardImage); // Fixed missing parenthesis

  void paint(Canvas canvas, Size size) {
    // Calculate scaling factors
    double imageAspectRatio = chalkboardImage.width.toDouble() / chalkboardImage.height.toDouble();
    double canvasAspectRatio = size.width / size.height;
    double scaleFactor = canvasAspectRatio > imageAspectRatio ? size.height / chalkboardImage.height.toDouble() : size.width / chalkboardImage.width.toDouble();

    // Increase scaleFactor to make the image larger
    scaleFactor *= 5.0;

    // Calculate destination rectangle
    Rect destinationRect = Rect.fromLTWH(0, 0, chalkboardImage.width.toDouble() * scaleFactor, chalkboardImage.height.toDouble() * scaleFactor);

    // Draw chalkboard image with the calculated destination rectangle
    canvas.drawImageRect(
      chalkboardImage, // Image to draw
      Rect.fromLTWH(0, 0, chalkboardImage.width.toDouble(), chalkboardImage.height.toDouble()), // Source rect
      destinationRect, // Destination rect
      Paint(), // Paint
    );

    // Tally mark paint
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double startX = 20;
    double startY = size.height / 2 + 2;
    double lineLength = 30;

    int groupsOfFive = count ~/ 5;
    int leftover = count % 5;

    // Draw complete groups of five
    for (int i = 0; i < groupsOfFive; i++) {
      for (int j = 0; j < 4; j++) { // Draw vertical lines
        canvas.drawLine(
          Offset(startX + j * 10, startY - lineLength / 2),
          Offset(startX + j * 10, startY + lineLength / 2),
          paint,
        );
      }
      // Draw diagonal line crossing the four vertical lines
      canvas.drawLine(
        Offset(startX, startY - lineLength / 2),
        Offset(startX + 30, startY + lineLength / 2),
        paint,
      );
      startX += 50; // Space between sets of five
    }

    // Draw leftover vertical lines
    for (int i = 0; i < leftover; i++) {
      canvas.drawLine(
        Offset(startX + i * 10, startY - lineLength / 2),
        Offset(startX + i * 10, startY + lineLength / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Widget to use this painter
class TallyMarks extends StatelessWidget {
  final int count;
  final ui.Image chalkboardImage; // Added image parameter

  const TallyMarks({Key? key, required this.count, required this.chalkboardImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 50), // Adjust the size based on your UI needs
      painter: TallyMarksPainter(count, chalkboardImage), // Pass image to painter
    );
  }
}