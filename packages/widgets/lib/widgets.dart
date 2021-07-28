library widgets;

import 'package:flutter/material.dart';

class MainTestWidget extends StatelessWidget {
  const MainTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'test widget',
      style: TextStyle(fontSize: 100),
    );
  }
}
