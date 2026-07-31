/// Enterprise VerificationBannerWidget for warning unverified accounts.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Reusable email verification warning banner widget.
class VerificationBannerWidget extends StatelessWidget {
  /// Creates a [VerificationBannerWidget].
  const VerificationBannerWidget({required this.onResendTap, super.key});

  /// Resend verification email callback trigger.
  final VoidCallback onResendTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkWarning.withValues(alpha: 0.15)
            : AppColors.warning.withValues(alpha: 0.1),
        borderRadius: AppRadius.borderMedium,
        border: Border.all(
          color: isDark ? AppColors.darkWarning : AppColors.warning,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.mark_email_unread_outlined,
            color: isDark ? AppColors.darkWarning : AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              'Your email address is unverified. Please check your inbox.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
              ),
            ),
          ),
          GestureDetector(
            onTap: onResendTap,
            child: Text(
              'Resend',
              style: theme.textTheme.labelMedium?.copyWith(
                color: isDark ? AppColors.darkWarning : AppColors.warning,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
