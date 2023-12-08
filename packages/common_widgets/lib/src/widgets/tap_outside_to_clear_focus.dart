import 'package:flutter/material.dart';

class TapOutsideToClearFocus extends StatelessWidget {
  const TapOutsideToClearFocus({
    super.key,
    required this.child,
    this.afterAction,
  });

  final Widget child;
  final VoidCallback? afterAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }

        afterAction?.call();
      },
      child: child,
    );
  }
}
