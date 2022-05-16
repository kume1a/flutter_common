import 'package:flutter/material.dart';

enum _ContainerType { circular, square }

const Color _defaultColor = Color(0xFFE0E0E0);

class BlankContainer extends StatelessWidget {
  const BlankContainer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
    this.color = _defaultColor,
  })  : _containerType = _ContainerType.square,
        radius = null,
        super(key: key);

  const BlankContainer.circular({
    Key? key,
    required this.radius,
    this.color = _defaultColor,
  })  : _containerType = _ContainerType.circular,
        width = null,
        height = null,
        borderRadius = null,
        super(key: key);

  final _ContainerType _containerType;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    switch (_containerType) {
      case _ContainerType.circular:
        return Container(
          width: radius! / 2,
          height: radius! / 2,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      case _ContainerType.square:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
        );
    }
  }
}
