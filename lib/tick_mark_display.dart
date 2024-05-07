import 'package:flutter/material.dart';

class TallyMarksPainter extends CustomPainter {
  final int count;

  TallyMarksPainter(this.count);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the black background first
    var backgroundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Tally mark paint
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double startX = 10;
    double startY = size.height / 2;
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

  const TallyMarks({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 50), // Adjust the size based on your UI needs
      painter: TallyMarksPainter(count),
    );
  }
}