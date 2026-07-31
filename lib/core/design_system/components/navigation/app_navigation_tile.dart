/// Reusable Navigation Tile component for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Settings and menu list tile with leading icon, title, subtitle, and trailing widget.
class AppNavigationTile extends StatelessWidget {
  const AppNavigationTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? theme.colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        shape: AppRadius.shapeMd,
        leading: leadingIcon != null
            ? Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: effectiveIconColor.withValues(alpha: 0.1),
                  borderRadius: AppRadius.borderRadiusSm,
                ),
                child: Icon(leadingIcon, color: effectiveIconColor, size: 20),
              )
            : null,
        title: Text(
          title,
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: AppTypography.bodySmall.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        trailing:
            trailing ??
            Icon(
              Icons.chevron_right,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
