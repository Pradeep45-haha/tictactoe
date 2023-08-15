import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  final Color glowColor;
  final List<Shadow> shadows;
  final String text;
  final double fontSize;
  const ShadowText({
    super.key,
    required this.glowColor,
    required this.shadows,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Waiting For Other Player",
      style: TextStyle(
        fontSize: 30,
        color: glowColor,
        letterSpacing: 1,
        shadows: const [
          Shadow(
            color: Colors.greenAccent,
            blurRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }
}
