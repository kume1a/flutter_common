import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {
  const SliverSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  const SliverSizedBox.shrink({
    super.key,
  })  : width = 0,
        height = 0,
        child = null;

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
