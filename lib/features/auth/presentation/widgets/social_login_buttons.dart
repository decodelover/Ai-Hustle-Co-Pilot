/// Enterprise SocialLoginButtons component with authentic Google and GitHub brand logos.
library;

import 'package:ai_hustle_copilot/core/design_system/components/common/brand_icons.dart';
import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Reusable social authentication buttons (Google & GitHub).
class SocialLoginButtons extends StatelessWidget {
  /// Creates a [SocialLoginButtons].
  const SocialLoginButtons({
    super.key,
    this.onGooglePressed,
    this.onGitHubPressed,
    this.isLoading = false,
  });

  /// Google sign in callback.
  final VoidCallback? onGooglePressed;

  /// GitHub sign in callback.
  final VoidCallback? onGitHubPressed;

  /// Global loading state indicator.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Column(
      children: [
        AppButton(
          text: 'Continue with Google',
          variant: AppButtonVariant.outlined,
          iconWidget: const GoogleBrandIcon(),
          isLoading: isLoading,
          onPressed: onGooglePressed,
        ),
        const SizedBox(height: AppSpacing.space12),
        AppButton(
          text: 'Continue with GitHub',
          variant: AppButtonVariant.outlined,
          iconWidget: GitHubBrandIcon(
            color: isDark ? Colors.white : const Color(0xFF181717),
          ),
          isLoading: isLoading,
          onPressed: onGitHubPressed,
        ),
      ],
    );
  }
}
