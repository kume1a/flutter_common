import 'dart:math';

import 'package:flutter/material.dart';

class DashedRect extends StatelessWidget {
  const DashedRect({
    required this.width,
    required this.height,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.gap = 5,
    this.child,
  });

  const DashedRect.square({
    required double size,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.gap = 5,
    this.child,
  })  : width = size,
        height = size;

  final double width;
  final double height;
  final Color color;
  final double strokeWidth;
  final double gap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: CustomPaint(
          painter: DashRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
          child: child,
        ),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  DashRectPainter({this.strokeWidth = 5.0, this.color = Colors.black, this.gap = 5.0})
      : _dashedPaint = Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

  final double strokeWidth;
  final Color color;
  final double gap;

  final Paint _dashedPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final double x = size.width;
    final double y = size.height;

    final Path _topPath = getDashedPath(
      a: const Point<double>(0, 0),
      b: Point<double>(x, 0),
      gap: gap,
    );

    final Path _rightPath = getDashedPath(
      a: Point<double>(x, 0),
      b: Point<double>(x, y),
      gap: gap,
    );

    final Path _bottomPath = getDashedPath(
      a: Point<double>(0, y),
      b: Point<double>(x, y),
      gap: gap,
    );

    final Path _leftPath = getDashedPath(
      a: const Point<double>(0, 0),
      b: Point<double>(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, _dashedPaint);
    canvas.drawPath(_rightPath, _dashedPaint);
    canvas.drawPath(_bottomPath, _dashedPaint);
    canvas.drawPath(_leftPath, _dashedPaint);
  }

  Path getDashedPath({
    required Point<double> a,
    required Point<double> b,
    required double gap,
  }) {
    final Size size = Size(b.x - a.x, b.y - a.y);
    final Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    Point<double> currentPoint = Point<double>(a.x, a.y);

    final double radians = atan(size.height / size.width);
    final double dx = cos(radians) * gap < 0 ? cos(radians) * gap * -1 : cos(radians) * gap;
    final double dy = sin(radians) * gap < 0 ? sin(radians) * gap * -1 : sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw ? path.lineTo(currentPoint.x, currentPoint.y) : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = Point<double>(currentPoint.x + dx, currentPoint.y + dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
