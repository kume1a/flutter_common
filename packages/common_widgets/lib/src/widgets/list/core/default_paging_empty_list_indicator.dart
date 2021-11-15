import 'package:flutter/material.dart';

class DefaultPagingEmptyListIndicator extends StatelessWidget {
  const DefaultPagingEmptyListIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'No items found',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
