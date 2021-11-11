import 'package:flutter/material.dart';

class TapOutsideToClearFocus extends StatelessWidget {
  const TapOutsideToClearFocus({
    Key? key,
    required this.child,
    this.afterAction,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? afterAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }

        afterAction?.call();
      },
      child: child,
    );
  }
}
