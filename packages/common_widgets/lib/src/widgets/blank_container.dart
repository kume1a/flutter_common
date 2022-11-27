import 'package:flutter/material.dart';

const Color _defaultColor = Color(0xFFE0E0E0);

class BlankContainer extends StatelessWidget {
  const BlankContainer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.color = _defaultColor,
    this.padding,
    this.margin,
  }) : super(key: key);

  const BlankContainer.circular({
    Key? key,
    required double radius,
    this.color = _defaultColor,
    this.padding,
    this.margin,
  })  : width = radius * 2,
        height = radius * 2,
        borderRadius = null,
        super(key: key);

  const BlankContainer.square({
    Key? key,
    required double size,
    this.borderRadius,
    this.color = _defaultColor,
    this.padding,
    this.margin,
  })  : width = size,
        height = size,
        super(key: key);

  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color? color;

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
      ),
    );
  }
}
