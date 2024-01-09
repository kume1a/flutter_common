import 'package:flutter/material.dart';

class ValidatedForm extends StatelessWidget {
  const ValidatedForm({
    super.key,
    required this.showErrors,
    required this.child,
  });

  final bool showErrors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: showErrors ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: child,
    );
  }
}
