import 'package:flutter/material.dart';

class DefaultForm extends StatelessWidget {
  const DefaultForm({
    Key? key,
    required this.child,
    required this.showErrors,
  }) : super(key: key);

  final Widget child;
  final bool showErrors;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: showErrors ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: child,
    );
  }
}