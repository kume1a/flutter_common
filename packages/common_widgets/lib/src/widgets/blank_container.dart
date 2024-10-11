import 'package:flutter/material.dart';

const Color _defaultColor = Color(0xFFE0E0E0);

class BlankContainer extends StatelessWidget {
  const BlankContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.color = _defaultColor,
    this.padding,
    this.margin,
  }) : _shape = BoxShape.rectangle;

  const BlankContainer.circular({
    super.key,
    required double radius,
    this.color = _defaultColor,
    this.padding,
    this.margin,
  })  : width = radius * 2,
        height = radius * 2,
        borderRadius = null,
        _shape = BoxShape.circle;

  const BlankContainer.square({
    super.key,
    required double size,
    this.borderRadius,
    this.color = _defaultColor,
    this.padding,
    this.margin,
  })  : width = size,
        height = size,
        _shape = BoxShape.rectangle;

  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color? color;

  final BoxShape _shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        shape: _shape,
      ),
    );
  }
}
