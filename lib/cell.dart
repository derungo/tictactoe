//cell.dart
import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const Cell({super.key, required this.text, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: color.withOpacity(0.75),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 72,
              fontFamily: 'Comic Sans MS',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
