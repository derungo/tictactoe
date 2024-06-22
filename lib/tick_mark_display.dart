import 'package:flutter/material.dart';

class TallyMarksPainter extends CustomPainter {
  final int count;

  TallyMarksPainter(this.count);

  @override
  void paint(Canvas canvas, Size size) {
    // Tally mark paint
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double startX = 20;
    double startY = 40; // Adjusted startY to position at the top left
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

  const TallyMarks({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3.85, // Adjust this to maintain the aspect ratio of the chalkboard image
      child: CustomPaint(
        painter: TallyMarksPainter(count),
      ),
    );
  }
}
