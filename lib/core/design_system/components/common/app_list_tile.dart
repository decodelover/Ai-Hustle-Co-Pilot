/// Production-ready enterprise AppListTile supporting leading, title, subtitle,
/// trailing, selected state, hover effects, and WCAG AA touch targets.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 ListTile component.
class AppListTile extends StatelessWidget {
  /// Creates an [AppListTile].
  const AppListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.isDisabled = false,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.space16,
      vertical: AppSpacing.space12,
    ),
  });

  /// Tile title string or widget.
  final String title;

  /// Optional subtitle description string.
  final String? subtitle;

  /// Optional leading widget (icon, avatar, checkbox).
  final Widget? leading;

  /// Optional trailing widget (chevron, switch, badge).
  final Widget? trailing;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Long press callback.
  final VoidCallback? onLongPress;

  /// Selected state boolean.
  final bool isSelected;

  /// Disabled state boolean.
  final bool isDisabled;

  /// Inner content padding.
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final tileColor = isSelected
        ? (isDark
              ? AppColors.darkPrimary.withValues(alpha: 0.15)
              : AppColors.primary.withValues(alpha: 0.1))
        : Colors.transparent;

    final titleColor = isDisabled
        ? (isDark ? AppColors.darkDisabledText : AppColors.disabledText)
        : (isSelected
              ? (isDark ? AppColors.darkPrimary : AppColors.primary)
              : (isDark ? AppColors.darkOnSurface : AppColors.onSurface));

    final subtitleColor = isDisabled
        ? (isDark ? AppColors.darkDisabledText : AppColors.disabledText)
        : (isDark
              ? AppColors.darkOnSurfaceVariant
              : AppColors.onSurfaceVariant);

    return Material(
      color: tileColor,
      borderRadius: AppRadius.borderMedium,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        onLongPress: isDisabled ? null : onLongPress,
        borderRadius: AppRadius.borderMedium,
        child: Padding(
          padding: contentPadding,
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AppSpacing.space16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: titleColor,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AppSpacing.space16),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
