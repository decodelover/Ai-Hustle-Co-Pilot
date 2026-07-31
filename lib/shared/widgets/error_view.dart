/// Reusable error view widget wrapping design system AppErrorState.
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_error_state.dart';
import 'package:flutter/material.dart';

/// Centered error view wrapping design system feedback component.
class ErrorView extends StatelessWidget {
  const ErrorView({required this.message, super.key, this.onRetry, this.icon});

  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AppErrorState(
      message: message,
      icon: icon ?? Icons.error_outline_rounded,
      onRetry: onRetry,
    );
  }
}
