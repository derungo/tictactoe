import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const Cell({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (text == 'X') {
      content = Image.asset('assets/x.webp', fit: BoxFit.contain);
    } else if (text == 'O') {
      content = Image.asset('assets/o.webp', fit: BoxFit.contain);
    } else {
      content = Container(); // Empty cell
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Center(child: content),
      ),
    );
  }
}
