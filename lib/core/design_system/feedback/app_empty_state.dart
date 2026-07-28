/// Production-ready enterprise AppEmptyState for the 4-state UI lifecycle.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_button.dart';
import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Empty State component.
class AppEmptyState extends StatelessWidget {
  /// Creates an [AppEmptyState].
  const AppEmptyState({
    required this.title,
    super.key,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.illustration,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
  });

  /// Primary empty state title.
  final String title;

  /// Secondary description subtitle.
  final String? subtitle;

  /// Icon visual fallback.
  final IconData icon;

  /// Custom graphic or illustration widget.
  final Widget? illustration;

  /// Primary button label text.
  final String? primaryActionLabel;

  /// Primary button action callback.
  final VoidCallback? onPrimaryAction;

  /// Secondary button label text.
  final String? secondaryActionLabel;

  /// Secondary button action callback.
  final VoidCallback? onSecondaryAction;

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
            illustration ??
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkPrimary.withValues(alpha: 0.15)
                        : AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 40.0,
                    color: isDark ? AppColors.darkPrimary : AppColors.primary,
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
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.space8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.darkOnSurfaceVariant
                      : AppColors.onSurfaceVariant,
                ),
              ),
            ],
            if (primaryActionLabel != null || secondaryActionLabel != null) ...[
              const SizedBox(height: AppSpacing.space24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (secondaryActionLabel != null) ...[
                    AppButton(
                      text: secondaryActionLabel!,
                      variant: AppButtonVariant.outlined,
                      fullWidth: false,
                      onPressed: onSecondaryAction,
                    ),
                    if (primaryActionLabel != null)
                      const SizedBox(width: AppSpacing.space12),
                  ],
                  if (primaryActionLabel != null)
                    AppButton(
                      text: primaryActionLabel!,
                      fullWidth: false,
                      onPressed: onPrimaryAction,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
