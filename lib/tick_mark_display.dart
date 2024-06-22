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

    double startX = size.width * 0.1; // Start 5% from the left
    double startY = size.height * 0.05; // Start 5% from the top
    double lineLength = size.height * 0.1; // Adjust line length based on the size

    int groupsOfFive = count ~/ 5;
    int leftover = count % 5;

    // Draw complete groups of five
    for (int i = 0; i < groupsOfFive; i++) {
      for (int j = 0; j < 4; j++) { // Draw vertical lines
        canvas.drawLine(
          Offset(startX + j * lineLength * 0.33, startY),
          Offset(startX + j * lineLength * 0.33, startY + lineLength),
          paint,
        );
      }
      // Draw diagonal line crossing the four vertical lines
      canvas.drawLine(
        Offset(startX, startY),
        Offset(startX + lineLength * 1.2, startY + lineLength),
        paint,
      );
      startX += lineLength * 1.5; // Space between sets of five
    }

    // Draw leftover vertical lines
    for (int i = 0; i < leftover; i++) {
      canvas.drawLine(
        Offset(startX + i * lineLength * 0.33, startY),
        Offset(startX + i * lineLength * 0.33, startY + lineLength),
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
    return CustomPaint(
      painter: TallyMarksPainter(count),
    );
  }
}
