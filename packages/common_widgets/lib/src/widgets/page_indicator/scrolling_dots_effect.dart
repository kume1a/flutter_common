import 'dart:math';

import 'package:flutter/material.dart';

import 'indicator_effect.dart';
import 'indicator_painter.dart';

class ScrollingDotsEffect extends BasicIndicatorEffect {
  const ScrollingDotsEffect({
    this.activeStrokeWidth = 1.5,
    this.activeDotScale = 1.3,
    this.maxVisibleDots = 5,
    this.fixedCenter = false,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotScale >= 0.0),
        assert(maxVisibleDots >= 5 && maxVisibleDots % 2 != 0),
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

  /// The active dot strokeWidth
  /// this is ignored if [fixedCenter] is false
  final double activeStrokeWidth;

  /// [activeDotScale] is multiplied by [dotWidth] to resolve
  /// active dot scaling
  final double activeDotScale;

  /// The max number of dots to display at a time
  /// if count is <= [maxVisibleDots] [maxVisibleDots] = count
  /// must be an odd number that's >= 5
  final int maxVisibleDots;

  // if True the old center dot style will be used
  final bool fixedCenter;

  @override
  Size calculateSize(int count) {
    // Add the scaled dot width to our size calculation
    double width = (dotWidth + spacing) * (min(count, maxVisibleDots));
    if (fixedCenter && count <= maxVisibleDots) {
      width = ((count * 2) - 1) * (dotWidth + spacing);
    }
    return Size(width, dotHeight * activeDotScale);
  }

  @override
  int hitTestDots(double dx, int count, double current) {
    final int switchPoint = (maxVisibleDots / 2).floor();
    if (fixedCenter) {
      return super.hitTestDots(dx, count, current) - switchPoint + current.floor();
    } else {
      final int firstVisibleDot = (current < switchPoint || count - 1 < maxVisibleDots)
          ? 0
          : min(current - switchPoint, count - maxVisibleDots).floor();
      final int lastVisibleDot = min(firstVisibleDot + maxVisibleDots, count - 1);
      double offset = 0.0;
      for (int index = firstVisibleDot; index <= lastVisibleDot; index++) {
        if (dx <= (offset += dotWidth + spacing)) {
          return index;
        }
      }
    }
    return -1;
  }

  @override
  BasicIndicatorPainter buildPainter(int count, double offset) {
    if (fixedCenter) {
      assert(
        offset.ceil() < count,
        'ScrollingDotsWithFixedCenterPainter does not support infinite looping.',
      );
      return ScrollingDotsWithFixedCenterPainter(
        count: count,
        offset: offset,
        effect: this,
      );
    } else {
      return ScrollingDotsPainter(
        count: count,
        offset: offset,
        effect: this,
      );
    }
  }
}

class ScrollingDotsPainter extends BasicIndicatorPainter {
  ScrollingDotsPainter({
    required this.effect,
    required int count,
    required double offset,
  }) : super(offset, count, effect);

  final ScrollingDotsEffect effect;

  @override
  void paint(Canvas canvas, Size size) {
    final int current = super.offset.floor();
    final int switchPoint = (effect.maxVisibleDots / 2).floor();
    final int firstVisibleDot = (current < switchPoint || count - 1 < effect.maxVisibleDots)
        ? 0
        : min(current - switchPoint, count - effect.maxVisibleDots);
    final int lastVisibleDot = min(firstVisibleDot + effect.maxVisibleDots, count - 1);
    final bool inPreScrollRange = current < switchPoint;
    final bool inAfterScrollRange = current >= (count - 1) - switchPoint;
    final bool willStartScrolling = (current + 1) == switchPoint + 1;
    final bool willStopScrolling = current + 1 == (count - 1) - switchPoint;

    final double dotOffset = offset - offset.toInt();
    final Paint dotPaint = Paint()
      ..strokeWidth = effect.strokeWidth
      ..style = effect.paintStyle;

    final double drawingAnchor = (inPreScrollRange || inAfterScrollRange)
        ? -(firstVisibleDot * distance)
        : -((offset - switchPoint) * distance);

    const double smallDotScale = 0.66;
    final double activeScale = effect.activeDotScale - 1.0;
    for (int index = firstVisibleDot; index <= lastVisibleDot; index++) {
      Color color = effect.dotColor;

      double scale = 1.0;

      if (index == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset)!;
        if (offset > count - 1 && count > effect.maxVisibleDots) {
          scale = effect.activeDotScale - (smallDotScale * dotOffset);
        } else {
          scale = effect.activeDotScale - (activeScale * dotOffset);
        }
      } else if (index == firstVisibleDot && offset > count - 1) {
        color = Color.lerp(effect.dotColor, effect.activeDotColor, dotOffset)!;
        if (count <= effect.maxVisibleDots) {
          scale = 1 + (activeScale * dotOffset);
        } else {
          scale = smallDotScale + (((1 - smallDotScale) + activeScale) * dotOffset);
        }
      } else if (index - 1 == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effect.dotColor, effect.activeDotColor, dotOffset)!;
        scale = 1.0 + (activeScale * dotOffset);
      } else if (count - 1 < effect.maxVisibleDots) {
        scale = 1.0;
      } else if (index == firstVisibleDot) {
        if (willStartScrolling) {
          scale = 1.0 * (1.0 - dotOffset);
        } else if (inAfterScrollRange) {
          scale = smallDotScale;
        } else if (!inPreScrollRange) {
          scale = smallDotScale * (1.0 - dotOffset);
        }
      } else if (index == firstVisibleDot + 1 && !(inPreScrollRange || inAfterScrollRange)) {
        scale = 1.0 - (dotOffset * (1.0 - smallDotScale));
      } else if (index == lastVisibleDot - 1.0) {
        if (inPreScrollRange) {
          scale = smallDotScale;
        } else if (!inAfterScrollRange) {
          scale = smallDotScale + ((1.0 - smallDotScale) * dotOffset);
        }
      } else if (index == lastVisibleDot) {
        if (inPreScrollRange) {
          scale = 0.0;
        } else if (willStopScrolling) {
          scale = dotOffset;
        } else if (!inAfterScrollRange) {
          scale = smallDotScale * dotOffset;
        }
      }

      final double scaledWidth = effect.dotWidth * scale;
      final double scaledHeight = effect.dotHeight * scale;
      final double yPos = size.height / 2;
      final double xPos = effect.dotWidth / 2 + drawingAnchor + (index * distance);

      final RRect rRect = RRect.fromLTRBR(
        xPos - scaledWidth / 2 + effect.spacing / 2,
        yPos - scaledHeight / 2,
        xPos + scaledWidth / 2 + effect.spacing / 2,
        yPos + scaledHeight / 2,
        dotRadius * scale,
      );

      canvas.drawRRect(rRect, dotPaint..color = color);
    }
  }
}

class ScrollingDotsWithFixedCenterPainter extends BasicIndicatorPainter {
  ScrollingDotsWithFixedCenterPainter({
    required this.effect,
    required int count,
    required double offset,
  }) : super(offset, count, effect);
  final ScrollingDotsEffect effect;

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    final double dotOffset = offset - current;
    final Paint dotPaint = Paint()
      ..strokeWidth = effect.strokeWidth
      ..style = effect.paintStyle;

    for (int index = 0; index < count; index++) {
      Color color = effect.dotColor;
      if (index == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset)!;
      } else if (index - 1 == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effect.activeDotColor, effect.dotColor, 1 - dotOffset)!;
      }

      double scale = 1.0;
      const double smallDotScale = 0.66;
      final double revDotOffset = 1 - dotOffset;
      final double switchPoint = (effect.maxVisibleDots - 1) / 2;

      if (count > effect.maxVisibleDots) {
        if (index >= current - switchPoint && index <= current + (switchPoint + 1)) {
          if (index == (current + switchPoint)) {
            scale = smallDotScale + ((1 - smallDotScale) * dotOffset);
          } else if (index == current - (switchPoint - 1)) {
            scale = 1 - (1 - smallDotScale) * dotOffset;
          } else if (index == current - switchPoint) {
            scale = smallDotScale * revDotOffset;
          } else if (index == current + (switchPoint + 1)) {
            scale = smallDotScale * dotOffset;
          }
        } else {
          continue;
        }
      }

      final RRect rRect = _calcBounds(
        size.height,
        size.width / 2 - (offset * (effect.dotWidth + effect.spacing)),
        index,
        scale,
      );

      canvas.drawRRect(rRect, dotPaint..color = color);
    }

    final RRect rRect = _calcBounds(size.height, size.width / 2, 0, effect.activeDotScale);
    canvas.drawRRect(
      rRect,
      Paint()
        ..color = effect.activeDotColor
        ..strokeWidth = effect.activeStrokeWidth
        ..style = PaintingStyle.stroke,
    );
  }

  RRect _calcBounds(double canvasHeight, double startingPoint, num i, [double scale = 1.0]) {
    final double scaledWidth = effect.dotWidth * scale;
    final double scaledHeight = effect.dotHeight * scale;

    final double xPos = startingPoint + (effect.dotWidth + effect.spacing) * i;
    final double yPos = canvasHeight / 2;
    return RRect.fromLTRBR(
      xPos - scaledWidth / 2,
      yPos - scaledHeight / 2,
      xPos + scaledWidth / 2,
      yPos + scaledHeight / 2,
      dotRadius * scale,
    );
  }
}
