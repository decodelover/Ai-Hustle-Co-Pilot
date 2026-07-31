/// Shared dashboard surfaces and section headers.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Visual tone for a dashboard surface.
enum DashboardSurfaceTone { standard, subtle, navy }

/// Reusable dashboard surface with consistent radius, border, and press state.
class DashboardSurface extends StatelessWidget {
  /// Creates a dashboard surface.
  const DashboardSurface({
    required this.child,
    this.tone = DashboardSurfaceTone.standard,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.space20),
    super.key,
  });

  /// Content rendered inside the surface.
  final Widget child;

  /// Surface tone.
  final DashboardSurfaceTone tone;

  /// Optional interaction callback.
  final VoidCallback? onTap;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isNavy = tone == DashboardSurfaceTone.navy;
    final background = switch (tone) {
      DashboardSurfaceTone.standard => AppColors.surface,
      DashboardSurfaceTone.subtle => AppColors.surfaceVariant,
      DashboardSurfaceTone.navy => AppColors.primaryDarkBlue,
    };
    final foreground = isNavy ? AppColors.onPrimary : AppColors.primaryText;
    final border = isNavy
        ? AppColors.onPrimary.withValues(alpha: 0.12)
        : AppColors.outline;

    return Semantics(
      button: onTap != null,
      child: Material(
        color: background,
        elevation: isNavy ? 0 : 1,
        shadowColor: AppColors.primaryDarkBlue.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderLarge,
          side: BorderSide(color: border),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.borderLarge,
          child: Padding(
            padding: padding,
            child: IconTheme(
              data: IconThemeData(color: foreground),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Consistent title row for dashboard content groups.
class DashboardSectionHeader extends StatelessWidget {
  /// Creates a dashboard section header.
  const DashboardSectionHeader({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// Section title.
  final String title;

  /// Optional supporting copy.
  final String? subtitle;

  /// Optional action label.
  final String? actionLabel;

  /// Optional action callback.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.headlineSmall),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.space4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (actionLabel != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}
