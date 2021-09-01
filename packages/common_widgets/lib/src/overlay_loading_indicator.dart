import 'package:flutter/material.dart';

class OverlayLoadingIndicator extends StatelessWidget {
  const OverlayLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
