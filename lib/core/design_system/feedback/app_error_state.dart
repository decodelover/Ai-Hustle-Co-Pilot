/// Production-ready enterprise AppErrorState for the 4-state UI lifecycle error handling.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_button.dart';
import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Error State component.
class AppErrorState extends StatelessWidget {
  /// Creates an [AppErrorState].
  const AppErrorState({
    required this.message,
    super.key,
    this.title = 'Something went wrong',
    this.icon = Icons.error_outline_rounded,
    this.onRetry,
    this.retryLabel = 'Try Again',
  });

  /// Error summary heading.
  final String title;

  /// User-friendly error message description.
  final String message;

  /// Visual error icon.
  final IconData icon;

  /// Interactive retry callback trigger.
  final VoidCallback? onRetry;

  /// Retry button label.
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkDanger.withValues(alpha: 0.15)
                    : AppColors.danger.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40.0,
                color: isDark ? AppColors.darkDanger : AppColors.danger,
              ),
            ),
            const SizedBox(height: AppSpacing.space24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.darkOnSurfaceVariant
                    : AppColors.onSurfaceVariant,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.space24),
              AppButton(
                text: retryLabel,
                icon: Icons.refresh_rounded,
                fullWidth: false,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
