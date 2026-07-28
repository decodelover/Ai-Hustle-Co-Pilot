/// Reusable enterprise AppSectionHeader for section titles across screens.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Section Header component.
class AppSectionHeader extends StatelessWidget {
  /// Creates an [AppSectionHeader].
  const AppSectionHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.action,
    this.padding = const EdgeInsets.only(
      bottom: AppSpacing.space16,
    ),
  });

  /// Primary section header title.
  final String title;

  /// Optional subtitle or helper text.
  final String? subtitle;

  /// Optional right-aligned action widget (button, view-all link).
  final Widget? action;

  /// Outer padding bounds.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkOnSurfaceVariant
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) ...[
            const SizedBox(width: AppSpacing.space16),
            action!,
          ],
        ],
      ),
    );
  }
}
