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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (s.title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  s.title!,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      foregroundColor: theme.colorScheme.onSecondaryContainer,
                    ),
                    child: Text(
                      s.negativeLabel,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    child: Text(
                      s.positiveLabel,
                      style: const TextStyle(fontSize: 13),
                    ),
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
