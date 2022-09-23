import 'package:flutter/material.dart';

import 'indicator_effect.dart';
import 'indicator_painter.dart';

class ExpandingDotsEffect extends BasicIndicatorEffect {
  const ExpandingDotsEffect({
    this.expansionFactor = 3,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16.0,
    Color activeDotColor = Colors.indigo,
    Color dotColor = Colors.grey,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(expansionFactor > 1),
        super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
        );

  final double expansionFactor;

  @override
  Size calculateSize(int count) {
    // Add the expanded dot width to our size calculation
    return Size(((dotWidth + spacing) * (count - 1)) + (expansionFactor * dotWidth), dotHeight);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return ExpandingDotsPainter(count: count, offset: offset, effect: this);
  }

  @override
  int hitTestDots(double dx, int count, double current) {
    double anchor = -spacing / 2;
    for (int index = 0; index < count; index++) {
      final double widthBound =
          (index == current ? (dotWidth * expansionFactor) : dotWidth) + spacing;
      if (dx <= (anchor += widthBound)) {
        return index;
      }
    }
    return -1;
  }
}

class ExpandingDotsPainter extends BasicIndicatorPainter {
  ExpandingDotsPainter({
    required double offset,
    required this.effect,
    required int count,
  }) : super(offset, count, effect);
  final ExpandingDotsEffect effect;

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    double drawingOffset = -effect.spacing;
    final double dotOffset = offset - current;

    for (int i = 0; i < count; i++) {
      Color color = effect.dotColor;
      final double activeDotWidth = effect.dotWidth * effect.expansionFactor;
      final double expansion = dotOffset / 2 * ((activeDotWidth - effect.dotWidth) / .5);
      final double xPos = drawingOffset + effect.spacing;
      double width = effect.dotWidth;
      if (i == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset)!;
        width = activeDotWidth - expansion;
      } else if (i - 1 == current || (i == 0 && offset > count - 1)) {
        width = effect.dotWidth + expansion;
        // ! Both a and b are non nullable
        color = Color.lerp(effect.activeDotColor, effect.dotColor, 1.0 - dotOffset)!;
      }
      final double yPos = size.height / 2;
      final RRect rRect = RRect.fromLTRBR(
        xPos,
        yPos - effect.dotHeight / 2,
        xPos + width,
        yPos + effect.dotHeight / 2,
        dotRadius,
      );
      drawingOffset = rRect.right;
      canvas.drawRRect(rRect, dotPaint..color = color);
    }
  }
}
