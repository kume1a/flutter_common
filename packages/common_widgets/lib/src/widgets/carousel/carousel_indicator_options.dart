import 'package:flutter/material.dart';

import 'page_indicator.dart';

class CarouselIndicatorOptions {
  CarouselIndicatorOptions({
    this.spaceFromPageIndicatorToCarousel = 16,
    this.activeStrokeWidth = 1.5,
    this.activeDotScale = 1.3,
    this.maxVisibleDots = 5,
    this.dotWidth = 16,
    this.dotHeight = 16,
    this.spacing = 8,
    this.radius = 16,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.black87,
    this.paintStyle = PaintingStyle.fill,
    this.strokeWidth = 1,
    this.onDotClicked,
  });

  final double spaceFromPageIndicatorToCarousel;
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
  final OnDotClicked? onDotClicked;
}
