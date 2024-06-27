import 'package:flutter/material.dart';

import '../../shared/typedefs.dart';

class StatusDialogStrings {
  const StatusDialogStrings({
    required this.content,
    required this.buttonLabel,
  });

  final String content;
  final String buttonLabel;
}

class StatusDialog extends StatelessWidget {
  const StatusDialog({
    super.key,
    required this.strings,
    this.onPressed,
  });

  final ResolveWithContext<StatusDialogStrings> strings;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final s = strings(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 52, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              s.content,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () {
                onPressed?.call();
                Navigator.pop(context);
              },
              child: Text(s.buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
