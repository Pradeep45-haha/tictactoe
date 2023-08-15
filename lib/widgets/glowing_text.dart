import 'package:flutter/material.dart';

class GlowingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final List<Shadow> shadows;
  const GlowingText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        shadows: shadows,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
