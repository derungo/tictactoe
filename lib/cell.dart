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
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: color, // Set the color of the cell
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}