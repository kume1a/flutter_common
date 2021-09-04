import 'package:flutter/material.dart';

class OverlayLoadingIndicator extends StatelessWidget {
  const OverlayLoadingIndicator({
    Key? key,
    this.overlayColor = Colors.black26,
  }) : super(key: key);

  final Color overlayColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: overlayColor,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
