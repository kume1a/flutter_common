import 'package:flutter/material.dart';

import 'indicator_effect.dart';

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
  final IndicatorEffect effect;
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
  final IndicatorEffect effect;
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
  final IndicatorEffect effect;
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
