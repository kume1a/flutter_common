import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollListener extends StatelessWidget {
  const ScrollListener({
    Key? key,
    required this.child,
    this.onScrollUp,
    this.onScrollDown,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onScrollUp;
  final VoidCallback? onScrollDown;

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
        }
        return false;
      },
      child: child,
    );
  }
}
