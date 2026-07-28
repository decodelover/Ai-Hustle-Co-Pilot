/// Reusable Text Button component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Reusable text-only action button with 48dp minimum touch target.
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.label,
    super.key,
    this.onPressed,
    this.icon,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = foregroundColor ?? theme.colorScheme.primary;

    Widget childWidget;

    if (icon != null) {
      childWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelLarge.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      childWidget = Text(
        label,
        style: AppTypography.labelLarge.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: fg,
          minimumSize: const Size(
            AppSpacing.minTouchTarget,
            AppSpacing.minTouchTarget,
          ),
          shape: AppRadius.shapeMd,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        child: childWidget,
      ),
    );
  }
}
