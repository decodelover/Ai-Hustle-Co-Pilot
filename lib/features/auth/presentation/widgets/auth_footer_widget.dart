/// Enterprise AuthFooterWidget for switching between Sign In and Sign Up screens.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 13),
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
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
