/// Reusable Material 3 AppDialog component supporting title, subtitle, icon,
/// primary and secondary action buttons, and animated entrance.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_button.dart';
import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_elevation.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Dialog component.
class AppDialog extends StatelessWidget {
  /// Creates an [AppDialog].
  const AppDialog({
    required this.title,
    super.key,
    this.description,
    this.icon,
    this.iconColor,
    this.content,
    this.primaryActionText,
    this.onPrimaryAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.isDestructive = false,
  });

  /// Static helper to trigger an animated [AppDialog].
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description,
    IconData? icon,
    Color? iconColor,
    Widget? content,
    String? primaryActionText,
    VoidCallback? onPrimaryAction,
    String? secondaryActionText,
    VoidCallback? onSecondaryAction,
    bool isDestructive = false,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        description: description,
        icon: icon,
        iconColor: iconColor,
        content: content,
        primaryActionText: primaryActionText,
        onPrimaryAction: onPrimaryAction,
        secondaryActionText: secondaryActionText,
        onSecondaryAction: onSecondaryAction,
        isDestructive: isDestructive,
      ),
    );
  }

  /// Dialog title string.
  final String title;

  /// Optional description body text.
  final String? description;

  /// Optional top header icon.
  final IconData? icon;

  /// Icon color override.
  final Color? iconColor;

  /// Custom inner content widget.
  final Widget? content;

  /// Primary button text.
  final String? primaryActionText;

  /// Primary action callback.
  final VoidCallback? onPrimaryAction;

  /// Secondary button text.
  final String? secondaryActionText;

  /// Secondary action callback.
  final VoidCallback? onSecondaryAction;

  /// Applies destructive red styling to primary button when true.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final defaultIconColor = isDestructive
        ? (isDark ? AppColors.darkDanger : AppColors.danger)
        : (isDark ? AppColors.darkPrimary : AppColors.primary);

    return Dialog(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
      elevation: AppElevation.level4,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderXLarge),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (icon != null) ...[
              Align(
                child: Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: (iconColor ?? defaultIconColor).withValues(
                      alpha: 0.1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? defaultIconColor,
                    size: 24.0,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
            ],
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
              ),
            ),
            if (description != null) ...[
              const SizedBox(height: AppSpacing.space8),
              Text(
                description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.darkOnSurfaceVariant
                      : AppColors.onSurfaceVariant,
                ),
              ),
            ],
            if (content != null) ...[
              const SizedBox(height: AppSpacing.space16),
              content!,
            ],
            if (primaryActionText != null || secondaryActionText != null) ...[
              const SizedBox(height: AppSpacing.space24),
              Row(
                children: [
                  if (secondaryActionText != null) ...[
                    Expanded(
                      child: AppButton(
                        text: secondaryActionText!,
                        variant: AppButtonVariant.outlined,
                        onPressed:
                            onSecondaryAction ??
                            () => Navigator.of(context).pop(),
                      ),
                    ),
                    if (primaryActionText != null)
                      const SizedBox(width: AppSpacing.space12),
                  ],
                  if (primaryActionText != null)
                    Expanded(
                      child: AppButton(
                        text: primaryActionText!,
                        variant: isDestructive
                            ? AppButtonVariant.destructive
                            : AppButtonVariant.primary,
                        onPressed:
                            onPrimaryAction ??
                            () => Navigator.of(context).pop(),
                      ),
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
