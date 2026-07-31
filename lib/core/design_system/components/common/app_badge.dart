/// Reusable enterprise AppBadge component supporting primary, secondary, success,
/// warning, danger, info, and outline variants, with dot badge support.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Available visual variants for [AppBadge].
enum AppBadgeVariant {
  /// Primary violet badge.
  primary,

  /// Secondary indigo badge.
  secondary,

  /// Emerald green success badge.
  success,

  /// Amber warning badge.
  warning,

  /// Danger red badge.
  danger,

  /// Info blue badge.
  info,

  /// Outlined border stroke badge.
  outline,
}

/// Enterprise Material 3 Badge component.
class AppBadge extends StatelessWidget {
  /// Creates an [AppBadge].
  const AppBadge({
    super.key,
    this.label,
    this.variant = AppBadgeVariant.primary,
    this.icon,
    this.isDot = false,
  });

  /// Text label string.
  final String? label;

  /// Visual variant.
  final AppBadgeVariant variant;

  /// Optional leading icon.
  final IconData? icon;

  /// Displays compact dot indicator when true.
  final bool isDot;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    if (isDot) {
      final dotColor = _getDotColor(isDark);
      return Container(
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
      );
    }

    final (Color bg, Color fg, BorderSide border) = _resolveColors(isDark);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.borderPill,
        border: border != BorderSide.none
            ? Border.fromBorderSide(border)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12.0, color: fg),
            const SizedBox(width: AppSpacing.space4),
          ],
          if (label != null)
            Text(
              label!,
              style: theme.textTheme.labelMedium?.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
                fontSize: 11.0,
              ),
            ),
        ],
      ),
    );
  }

  Color _getDotColor(bool isDark) {
    switch (variant) {
      case AppBadgeVariant.primary:
        return isDark ? AppColors.darkPrimary : AppColors.primary;
      case AppBadgeVariant.secondary:
        return isDark ? AppColors.darkSecondary : AppColors.secondary;
      case AppBadgeVariant.success:
        return isDark ? AppColors.darkSuccess : AppColors.success;
      case AppBadgeVariant.warning:
        return isDark ? AppColors.darkWarning : AppColors.warning;
      case AppBadgeVariant.danger:
        return isDark ? AppColors.darkDanger : AppColors.danger;
      case AppBadgeVariant.info:
        return isDark ? AppColors.darkInfo : AppColors.info;
      case AppBadgeVariant.outline:
        return isDark ? AppColors.darkOnSurface : AppColors.onSurface;
    }
  }

  (Color bg, Color fg, BorderSide border) _resolveColors(bool isDark) {
    switch (variant) {
      case AppBadgeVariant.primary:
        return (
          isDark
              ? AppColors.darkPrimary.withValues(alpha: 0.2)
              : AppColors.primary.withValues(alpha: 0.1),
          isDark ? AppColors.darkPrimary : AppColors.primary,
          BorderSide.none,
        );
      case AppBadgeVariant.secondary:
        return (
          isDark
              ? AppColors.darkSecondary.withValues(alpha: 0.2)
              : AppColors.secondary.withValues(alpha: 0.1),
          isDark ? AppColors.darkSecondary : AppColors.secondary,
          BorderSide.none,
        );
      case AppBadgeVariant.success:
        return (
          isDark
              ? AppColors.darkSuccess.withValues(alpha: 0.2)
              : AppColors.success.withValues(alpha: 0.1),
          isDark ? AppColors.darkSuccess : AppColors.success,
          BorderSide.none,
        );
      case AppBadgeVariant.warning:
        return (
          isDark
              ? AppColors.darkWarning.withValues(alpha: 0.2)
              : AppColors.warning.withValues(alpha: 0.1),
          isDark ? AppColors.darkWarning : AppColors.warning,
          BorderSide.none,
        );
      case AppBadgeVariant.danger:
        return (
          isDark
              ? AppColors.darkDanger.withValues(alpha: 0.2)
              : AppColors.danger.withValues(alpha: 0.1),
          isDark ? AppColors.darkDanger : AppColors.danger,
          BorderSide.none,
        );
      case AppBadgeVariant.info:
        return (
          isDark
              ? AppColors.darkInfo.withValues(alpha: 0.2)
              : AppColors.info.withValues(alpha: 0.1),
          isDark ? AppColors.darkInfo : AppColors.info,
          BorderSide.none,
        );
      case AppBadgeVariant.outline:
        return (
          Colors.transparent,
          isDark ? AppColors.darkOnSurface : AppColors.onSurface,
          BorderSide(color: isDark ? AppColors.darkOutline : AppColors.outline),
        );
    }
  }
}
