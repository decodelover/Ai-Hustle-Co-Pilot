/// Enterprise AuthFooterWidget for switching between Sign In and Sign Up screens.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Reusable authentication footer prompt with semantic link navigation.
class AuthFooterWidget extends StatelessWidget {
  /// Creates an [AuthFooterWidget].
  const AuthFooterWidget({
    required this.promptText,
    required this.actionText,
    required this.onActionPressed,
    super.key,
  });

  /// Leading prompt string (e.g. "Don't have an account? ").
  final String promptText;

  /// Highlighted action text (e.g. "Sign Up").
  final String actionText;

  /// Navigation callback.
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          promptText,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark
                ? AppColors.darkOnSurfaceVariant
                : AppColors.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: onActionPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
