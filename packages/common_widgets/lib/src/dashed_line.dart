import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    Key? key,
    required this.width,
    this.axis = Axis.horizontal,
    this.dashWidth = 4,
    this.spacing = 8,
    this.thickness = 1,
    this.color = Colors.black87,
  }) : super(key: key);

  final double width;
  final Axis axis;
  final double dashWidth;
  final double spacing;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: axis == Axis.horizontal ? 0 : 1,
      child: CustomPaint(
        size: Size(width, thickness),
        painter: _DashedLinePainter(
          dashWidth: dashWidth,
          color: color,
          thickness: thickness,
          spacing: spacing,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({
    required this.dashWidth,
    required Color color,
    required double thickness,
    required this.spacing,
  }) : _paint = Paint()
          ..color = color
          ..strokeWidth = thickness;

  final double dashWidth;
  final double spacing;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), _paint);
      startX += dashWidth + spacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
