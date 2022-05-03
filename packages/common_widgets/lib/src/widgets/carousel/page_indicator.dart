import 'dart:math';

import 'package:flutter/material.dart';

typedef OnDotClicked = void Function(int index);

class PageIndicator extends AnimatedWidget {
  const PageIndicator({
    Key? key,
    required this.controller,
    required this.count,
    required this.effect,
    this.onDotClicked,
  }) : super(key: key, listenable: controller);

  final PageController controller;
  final ScrollingDotsEffect effect;
  final int count;
  final OnDotClicked? onDotClicked;

  @override
  Widget build(BuildContext context) {
    return Indicator(
      offset: _offset,
      count: count,
      effect: effect,
      onDotClicked: onDotClicked,
    );
  }

  double get _offset {
    try {
      return controller.page ?? controller.initialPage.toDouble();
    } catch (_) {
      return controller.initialPage.toDouble();
    }
  }
}

class Indicator extends StatelessWidget {
  Indicator({
    required this.offset,
    required this.count,
    required this.effect,
    this.onDotClicked,
    Key? key,
  })  : _size = effect.calculateSize(count),
        super(key: key);

  final double offset;
  final ScrollingDotsEffect effect;
  final int count;
  final OnDotClicked? onDotClicked;
  final Size _size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _onTap,
      child: CustomPaint(
        size: _size,
        painter: effect.buildPainter(count, offset),
      ),
    );
  }

  void _onTap(TapUpDetails details) {
    if (onDotClicked != null) {
      final int index = effect.hitTestDots(
        details.localPosition.dx,
        count,
        offset,
      );
      if (index != -1 && index != offset.toInt()) {
        onDotClicked?.call(index);
      }
    }
  }
}

class AnimatedPageIndicator extends ImplicitlyAnimatedWidget {
  const AnimatedPageIndicator({
    required this.activeIndex,
    required this.count,
    this.onDotClicked,
    required this.effect,
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 300),
    VoidCallback? onEnd,
    Key? key,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
        );

  final int activeIndex;
  final ScrollingDotsEffect effect;
  final int count;
  final Function(int index)? onDotClicked;

  @override
  _AnimatedPageIndicatorState createState() => _AnimatedPageIndicatorState();
}

class _AnimatedPageIndicatorState extends AnimatedWidgetBaseState<AnimatedPageIndicator> {
  Tween<double>? _offset;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _offset = visitor(
      _offset,
      widget.activeIndex.toDouble(),
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return Indicator(
      offset: _offset?.evaluate(animation) ?? 0,
      count: widget.count,
      effect: widget.effect,
      onDotClicked: widget.onDotClicked,
    );
  }
}

class ScrollingDotsEffect {
  const ScrollingDotsEffect({
    this.activeStrokeWidth = 1.5,
    this.activeDotScale = 1.3,
    this.maxVisibleDots = 5,
    this.strokeWidth = 1.0,
    this.dotWidth = 16.0,
    this.dotHeight = 16.0,
    this.spacing = 8.0,
    this.radius = 16,
    this.dotColor = Colors.grey,
    this.paintStyle = PaintingStyle.fill,
    this.activeDotColor = Colors.black87,
  })  : assert(activeDotScale >= 0.0),
        assert(maxVisibleDots >= 5 && maxVisibleDots % 2 != 0),
        assert(dotWidth >= 0 && dotHeight >= 0 && spacing >= 0 && strokeWidth >= 0);

  final double activeStrokeWidth;
  final double activeDotScale;
  final int maxVisibleDots;
  final double dotWidth;
  final double dotHeight;
  final double spacing;
  final double radius;
  final Color dotColor;
  final Color activeDotColor;
  final PaintingStyle paintStyle;
  final double strokeWidth;

  Size calculateSize(int count) {
    final double width = (dotWidth + spacing) * (min(count, maxVisibleDots));
    return Size(width, dotHeight * activeDotScale);
  }

  int hitTestDots(double dx, int count, double current) {
    final int switchPoint = (maxVisibleDots / 2).floor();
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
    return -1;
  }

  ScrollingDotsPainter buildPainter(int count, double offset) =>
      ScrollingDotsPainter(count: count, offset: offset, effect: this);
}

class ScrollingDotsPainter extends CustomPainter {
  ScrollingDotsPainter({
    required this.effect,
    required this.count,
    required this.offset,
  })  : assert(offset.ceil() < count, 'Current page is out of bounds'),
        dotRadius = Radius.circular(effect.radius),
        dotPaint = Paint()
          ..color = effect.dotColor
          ..style = effect.paintStyle
          ..strokeWidth = effect.strokeWidth;

  final ScrollingDotsEffect effect;
  final double offset;
  final int count;
  final Paint dotPaint;
  final Radius dotRadius;

  double get distance => effect.dotWidth + effect.spacing;

  void paintStillDots(Canvas canvas, Size size) {
    for (int i = 0; i < count; i++) {
      final double xPos = i * distance;
      final double yPos = size.height / 2;
      final Rect bounds =
          Rect.fromLTRB(xPos, yPos - effect.dotHeight / 2, xPos + effect.dotWidth, yPos + effect.dotHeight / 2);
      final RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
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

    final double drawingAnchor =
        (inPreScrollRange || inAfterScrollRange) ? -(firstVisibleDot * distance) : -((offset - switchPoint) * distance);

    const double smallDotScale = 0.66;
    final double activeScale = effect.activeDotScale - 1.0;
    for (int index = firstVisibleDot; index <= lastVisibleDot; index++) {
      Color color = effect.dotColor;

      double scale = 1.0;

      if (index == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset)!;
        scale = effect.activeDotScale - (activeScale * dotOffset);
      } else if (index - 1 == current) {
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

  @override
  bool shouldRepaint(ScrollingDotsPainter oldDelegate) => oldDelegate.offset != offset;
}
