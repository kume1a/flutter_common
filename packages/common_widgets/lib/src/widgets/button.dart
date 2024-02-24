import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  primaryContainer,
  secondary,
}

enum ButtonSize {
  sm,
  md,
}

class Button extends StatelessWidget {
  const Button({
    required this.onPressed,
    required this.child,
    this.showCircularProgressIndicator = false,
    this.variant = ButtonVariant.secondary,
    this.size = ButtonSize.md,
    this.style,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  final ButtonVariant variant;
  final ButtonSize size;
  final bool showCircularProgressIndicator;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Widget widget = showCircularProgressIndicator
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              const SizedBox(width: 8),
              const SizedBox.square(
                dimension: 15,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          )
        : child;

    switch (size) {
      case ButtonSize.sm:
        widget = DefaultTextStyle(
          style: const TextStyle(fontSize: 11),
          child: widget,
        );
      default:
        break;
    }

    return TextButton(
      onPressed: showCircularProgressIndicator ? null : onPressed,
      style: _resolveStyle(theme).merge(style),
      child: widget,
    );
  }

  ButtonStyle _resolveStyle(ThemeData theme) {
    EdgeInsets? padding;
    Color? backgroundColor;
    Color? foregroundColor;
    MaterialTapTargetSize? tapTargetSize;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.secondaryContainer;
      case ButtonVariant.primaryContainer:
        backgroundColor = theme.colorScheme.primaryContainer;
        foregroundColor = theme.colorScheme.secondaryContainer;
      case ButtonVariant.secondary:
        break;
    }

    switch (size) {
      case ButtonSize.sm:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        tapTargetSize = MaterialTapTargetSize.shrinkWrap;
      case ButtonSize.md:
        break;
    }

    return TextButton.styleFrom(
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      tapTargetSize: tapTargetSize,
    );
  }
}
