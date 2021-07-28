import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {
  const SliverSizedBox({
    Key? key,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  const SliverSizedBox.shrink({
    Key? key,
  })  : width = 0,
        height = 0,
        child = null,
        super(key: key);

  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
        key: key,
        child: child,
      ),
    );
  }
}
