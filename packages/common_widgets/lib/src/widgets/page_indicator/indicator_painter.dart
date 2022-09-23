import 'package:flutter/material.dart';

import 'indicator_effect.dart';

abstract class BasicIndicatorPainter extends IndicatorPainter {
  BasicIndicatorPainter(
    double offset,
    this.count,
    this._effect,
  )   : dotRadius = Radius.circular(_effect.radius),
        dotPaint = Paint()
          ..color = _effect.dotColor
          ..style = _effect.paintStyle
          ..strokeWidth = _effect.strokeWidth,
        super(offset);

  /// The count of pages
  final int count;

  // The provided effect is passed to this super class
  // to make some calculations and paint still dots
  final BasicIndicatorEffect _effect;

  /// Inactive dot paint or base paint in one-color effects.
  final Paint dotPaint;

  /// The Radius of all dots
  final Radius dotRadius;

  // The distance between dot lefts
  double get distance => _effect.dotWidth + _effect.spacing;

  void paintStillDots(Canvas canvas, Size size) {
    for (int i = 0; i < count; i++) {
      final double xPos = i * distance;
      final double yPos = size.height / 2;
      final Rect bounds = Rect.fromLTRB(
        xPos,
        yPos - _effect.dotHeight / 2,
        xPos + _effect.dotWidth,
        yPos + _effect.dotHeight / 2,
      );
      final RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  RRect calcPortalTravel(Size size, double offset, double dotOffset) {
    final double yPos = size.height / 2;
    final double width = dotOffset * (_effect.dotHeight / 2);
    final double height = dotOffset * (_effect.dotWidth / 2);
    final double xPos = offset;
    return RRect.fromLTRBR(
      xPos - height,
      yPos - width,
      xPos + height,
      yPos + width,
      Radius.circular(dotRadius.x * dotOffset),
    );
  }
}

abstract class IndicatorPainter extends CustomPainter {
  const IndicatorPainter(this.offset);

  final double offset;

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    // only repaint if the offset changes
    return oldDelegate.offset != offset;
  }
}
