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

    double startX = size.width * 0.1; // Start 10% from the left
    double startY = size.height * 0.05; // Start 5% from the top
    double lineLength = size.height * 0.1; // Adjust line length based on the size

    int groupsOfFive = count ~/ 5;
    int leftover = count % 5;
    int maxGroupsPerRow = 2; // Adjust this value to control how many groups of five per row
    int maxRows = 6; // Maximum number of rows

    // Calculate total groups including leftover
    int totalGroups = groupsOfFive + (leftover > 0 ? 1 : 0);

    // If total groups exceed max rows * max groups per row, reset
    if (totalGroups > maxRows * maxGroupsPerRow) {
      groupsOfFive = 0;
      leftover = 0;
    }

    // Draw complete groups of five
    for (int i = 0; i < groupsOfFive; i++) {
      if (i > 0 && i % maxGroupsPerRow == 0) {
        startX = size.width * 0.1; // Reset startX for a new row
        startY += lineLength * 1.5; // Move down for a new row
      }
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
    if (groupsOfFive > 0 && groupsOfFive % maxGroupsPerRow == 0) {
      startX = size.width * 0.1; // Reset startX for leftover lines if starting new row
      startY += lineLength * 1.5; // Move down for leftover lines if starting new row
    }
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
