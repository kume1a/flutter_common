import 'package:flutter/material.dart';

class DefaultPagingRefreshIndicator extends StatelessWidget {
  const DefaultPagingRefreshIndicator({
    Key? key,
    required this.onRefreshPressed,
  }) : super(key: key);

  final VoidCallback onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: IconButton(
          onPressed: onRefreshPressed,
          splashRadius: 24,
          icon: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
