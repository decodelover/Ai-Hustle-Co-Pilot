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
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.darkOnSurfaceVariant
                : AppColors.onSurfaceVariant,
          ),
        ),
        GestureDetector(
          onTap: onActionPressed,
          child: Text(
            actionText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.darkPrimary : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
