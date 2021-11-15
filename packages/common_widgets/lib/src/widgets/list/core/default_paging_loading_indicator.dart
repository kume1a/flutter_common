import 'package:flutter/material.dart';

class DefaultPagingLoadingIndicator extends StatelessWidget {
  const DefaultPagingLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
