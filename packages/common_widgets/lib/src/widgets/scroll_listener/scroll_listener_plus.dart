import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollListenerPlus extends StatelessWidget {
  const ScrollListenerPlus({
    Key? key,
    required this.child,
    this.onScrollUp,
    this.onScrollDown,
    this.onBellowBottomThreshold,
    this.onOverBottomThreshold,
    this.bottomThreshold = 0,
  })  : super(key: key);

  final Widget child;
  final VoidCallback? onScrollUp;
  final VoidCallback? onScrollDown;
  final VoidCallback? onBellowBottomThreshold;
  final VoidCallback? onOverBottomThreshold;
  final double bottomThreshold;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.axis == Axis.vertical && notification is UserScrollNotification) {
          if (notification.direction == ScrollDirection.reverse) {
            onScrollUp?.call();
          } else if (notification.direction == ScrollDirection.forward) {
            onScrollDown?.call();
          }

          if (onBellowBottomThreshold != null || onOverBottomThreshold != null) {
            final double _bottomThreshold = notification.metrics.maxScrollExtent - bottomThreshold;
            if (notification.metrics.pixels > _bottomThreshold) {
              onBellowBottomThreshold?.call();
            } else {
              onOverBottomThreshold?.call();
            }
          }
        }
        return false;
      },
      child: child,
    );
  }
}
