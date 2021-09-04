import 'package:flutter/material.dart';

extension CanvasX on Canvas {
  /// draws text on a painting
  ///
  /// @returns The amount of space required to paint this text.
  Size drawText({
    required TextSpan textSpan,
    required double offsetX,
    required double offsetY,
    double maxWidth = double.infinity,
    double minWidth = 0,
  }) {
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter
      ..layout(minWidth: minWidth, maxWidth: maxWidth)
      ..paint(this, Offset(offsetX, offsetY));

    return textPainter.size;
  }

  Size drawIcon({
    required IconData icon,
    required double offsetX,
    required double offsetY,
    double size = 24,
    Color? color,
  }) {
    final TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(fontSize: size, fontFamily: icon.fontFamily, color: color),
    );
    textPainter
      ..layout()
      ..paint(this, Offset(offsetX, offsetY));

    return textPainter.size;
  }
}
