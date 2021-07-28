import 'package:flutter/material.dart';

enum _ContainerType { circular, square }

class BlankContainer extends StatelessWidget {
  const BlankContainer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 0,
    this.color,
  })  : _containerType = _ContainerType.square,
        radius = null,
        super(key: key);

  const BlankContainer.circular({
    Key? key,
    required this.radius,
    this.color,
  })   : _containerType = _ContainerType.circular,
        width = null,
        height = null,
        borderRadius = null,
        super(key: key);

  final _ContainerType _containerType;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color color = this.color ?? Colors.grey.shade500;

    switch (_containerType) {
      case _ContainerType.circular:
        return CircleAvatar(
          backgroundColor: color,
          radius: radius,
        );
      case _ContainerType.square:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
          ),
        );
    }
  }
}
