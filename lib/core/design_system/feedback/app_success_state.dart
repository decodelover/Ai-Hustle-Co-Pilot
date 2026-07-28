/// Production-ready enterprise AppSuccessState for the 4-state UI lifecycle.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_button.dart';
import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Success State component.
class AppSuccessState extends StatelessWidget {
  /// Creates an [AppSuccessState].
  const AppSuccessState({
    required this.title,
    super.key,
    this.message,
    this.icon = Icons.check_circle_outline_rounded,
    this.actionLabel,
    this.onAction,
  });

  /// Success title header string.
  final String title;

  /// Optional message description string.
  final String? message;

  /// Success visual icon.
  final IconData icon;

  /// Action button label text.
  final String? actionLabel;

  /// Action button trigger callback.
  final VoidCallback? onAction;

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
                    ? AppColors.darkSuccess.withValues(alpha: 0.15)
                    : AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40.0,
                color: isDark ? AppColors.darkSuccess : AppColors.success,
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
            if (message != null) ...[
              const SizedBox(height: AppSpacing.space8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.darkOnSurfaceVariant
                      : AppColors.onSurfaceVariant,
                ),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.space24),
              AppButton(
                text: actionLabel!,
                variant: AppButtonVariant.success,
                fullWidth: false,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
