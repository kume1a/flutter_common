import 'package:flutter/material.dart';

import '../../shared/typedefs.dart';

class ConfirmationDialogStrings {
  const ConfirmationDialogStrings({
    required this.caption,
    required this.positiveLabel,
    required this.negativeLabel,
    this.title,
  });

  final String caption;
  final String? title;
  final String positiveLabel;
  final String negativeLabel;
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.strings,
  });

  final ResolveWithContext<ConfirmationDialogStrings> strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final s = strings(context);

    return Dialog(
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (s.title != null) ...[
              Text(
                s.title!,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
            ],
            Text(
              s.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      foregroundColor: theme.colorScheme.onSecondaryContainer,
                    ),
                    child: Text(s.negativeLabel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(s.positiveLabel),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
